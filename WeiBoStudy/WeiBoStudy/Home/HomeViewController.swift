//
//  HomeViewController.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/8/22.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

class HomeViewController: BaseViewController{


  

    
  //MARK:- 懒加载属性
    lazy var statuses:[StatusViewModel] = [StatusViewModel]()
    
    lazy var titleBtn:TitleButton = TitleButton()
    lazy var popoverAnimator:PopoverAnimator = PopoverAnimator()
    lazy var tipLabel : UILabel = UILabel()
 //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //请求数据
        setupHomeInfo(isNewDate: true)
     
        
        popoverAnimator.callBack = {
         (presented) in
            self.titleBtn.isSelected = presented
        }
visitorView.setupVistitorViewInfo(icoName: "visitordiscover_feed_image_house", title: "关注一些人,回这里看看有什么惊喜")
        visitorView.zpImage.isHidden = false
        visitorView.addRotationAnmin()
        if !isLogin {
            return
        }
//设置导航栏的内容
//        setupNavigationItems()
        setupNavigationBar()
        tableView.rowHeight = UITableViewAutomaticDimension
        //设置估算高度
        tableView.estimatedRowHeight = 200
        
        //布局刷新
        setupHeaderView()
        setupFooterView()
        //设置提示label
       stupTipLabel()
    }
    

    

   }

//MARK:- 设置UI界面
extension HomeViewController{
    func setupNavigationBar(){
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
    //1.设置左侧和右侧的Item

        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "navigationbar_friendattention")
           navigationItem.rightBarButtonItem = UIBarButtonItem.init(imageName: "navigationbar_pop")
    //设置titleView
        let string:String =   (UserAccounViewModel.shareIntace.account?.screen_name)!
        
        titleBtn.setTitle("\(string)", for: UIControlState.normal)

        titleBtn.addTarget(self, action: #selector(HomeViewController.titleBtnClick(titleBtn:)), for: UIControlEvents.touchUpInside)
        navigationItem.titleView = titleBtn
//self.tableView.register(UINib.init(nibName: "HomeViewCell", bundle: nil), forCellReuseIdentifier: "HomeViewCell")
    
        
    }
    
    func setupHeaderView(){
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadNewDates))
        //设置header属性
        header?.setTitle("下拉刷新", for: MJRefreshState.idle)
        header?.setTitle("释放刷新", for: .pulling)
     header?.setTitle("加载中...", for: .refreshing)
        //设置tableViewHeader
        tableView.mj_header = header
        //进入刷新状态
        tableView.mj_header.beginRefreshing()
    }
    func setupFooterView(){
    tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadMoreDates))
//        tableView.mj_footer.beginRefreshing()
    
    }
    func stupTipLabel(){
    //将tipLabel添加到父控件中
        navigationController?.navigationBar.insertSubview(tipLabel, at: 0)
//        view.addSubview(tipLabel)
        //设置farme
        tipLabel.frame = CGRect.init(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 32)
        tipLabel.backgroundColor = UIColor.orange
    tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.textAlignment = .center
        tipLabel.isHidden = true
    }

}

//MARK:- 事件监听
extension HomeViewController{
//监听事件
    @objc func titleBtnClick(titleBtn:TitleButton){
   //改变按钮状态
        titleBtn.isSelected = !titleBtn.isSelected
    LMLog(message: "titleView")
        //创建弹出控制器
        let poperVc = PoporViewController()
        //设置控制器的弹出样式
        poperVc.modalPresentationStyle = .custom
        //设置转场代理
        poperVc.transitioningDelegate = popoverAnimator
   popoverAnimator.presententedFrame = CGRect.init(x: UIScreen.main.bounds.size.width / 2 - 90, y: 60, width: 180, height: 250)
   
        
        //弹出控制器
    present(poperVc, animated: true, completion: nil)
        
        
        
        
    }


}
//MARK:- 获取主页网络请求数据
extension HomeViewController{
    @objc func loadNewDates(){
        setupHomeInfo(isNewDate: true)
        LMLog(message: "刷新")
    }
    @objc func loadMoreDates(){
        setupHomeInfo(isNewDate: false)
        LMLog(message: "刷新")
    }
    func setupHomeInfo(isNewDate:Bool){
        //获取since_id//获取max_id
        var since_id = 0
        var max_id = 0
        if isNewDate {
            since_id = statuses.first?.status?.mid ?? 0
        }else{
        max_id = statuses.last?.status?.mid ?? 0
            max_id = max_id==0 ? 0 : (max_id-1)
        }
        
    let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parDic = ["access_token":UserAccounViewModel.shareIntace.account?.access_token,"since_id":"\(since_id)","max_id" :"\(max_id)"]
    NetWorkingTools.shareInstace.request(methodType: .GET, urlString: urlString, parameters: (parDic as AnyObject) as! [String : AnyObject]) { (result, error) in
        if error != nil{
            LMLog(message:"\(String(describing: error))")
            return
        }
        guard  let result = result else{
        return
        }
//        LMLog(message: result)
        guard  let array : NSArray = result["statuses"] as? NSArray else{
         return
        }
//          LMLog(message: array)
        //遍历数组
        var temViewModel = [StatusViewModel]()
        for dic in array {
//            LMLog(message: dic);
            let status = Status(dict:dic as! [String : AnyObject])
            let viewModel = StatusViewModel(status: status)
            LMLog(message: viewModel.status?.retweeted_status)
    temViewModel.append(viewModel)
        }
        //将数据放入到成员变量的数组中
        if isNewDate {
         self.statuses =  temViewModel + self.statuses
        }else{
        self.statuses += temViewModel
        }
       
        //缓存图片
        self .cacheImages(viewModels: temViewModel)
        
    
    }

    }

    private func cacheImages(viewModels:[StatusViewModel]){
        //创建group
        let group = DispatchGroup()
        
        //缓存图片
        for viewModel in viewModels {
            for picUrl in viewModel.picUrls {
                group.enter()
                SDWebImageManager.shared().downloadImage(with: picUrl as URL, options: [], progress: nil, completed: { (_, _, _, _, _) in
                    LMLog(message: "下载了一张图片")
               group.leave()
                })
            }
        }
        //当上面所有的任务执行完之后通知
        group.notify(queue: .main) {
             self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            //显示提示label
            self.showTipLabel(count: viewModels.count)
           
            LMLog(message: "舒心")
        }
      
    }
    //显示提示label
    func showTipLabel(count:Int){
    //设置tipLabel属性
        tipLabel.isHidden = false
        tipLabel.text = count==0 ? "没有数据" : "\(count)条微博"
        //执行动画
     UIView.animate(withDuration: 1.0, animations: { 
        self.tipLabel.frame.origin.y = 44
     }) { (_) in
        UIView.animate(withDuration: 1.0, delay: 1.5, options: [], animations: {
            self.tipLabel.frame.origin.y = 10
        }, completion: { (_) in
            self.tipLabel.isHidden = true
        })
        }
        
//        UIView.animate(withDuration: 1.0, delay: 1.5, options: [], animations: { 
//            self.tipLabel.frame.origin.y = 10
//        }) { (_) in
//            self.tipLabel.isHidden = true
//        }
    
    }
    
}
//MARK:- tableView 数据源方法
extension HomeViewController{

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statuses.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeViewCell
        let viewModel = statuses[indexPath.row]
      cell.viewModel = viewModel
     
        return cell
   
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let viewModel = statuses[indexPath.row]
//        return viewModel.cellHeight
//    }
    

}





































