//
//  OAuthViewController.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/8/30.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {
//MARK:- 控件属性
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航栏内容
        setupNavigationBar()
        //加载网页
        loadPage()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

 // MARK: - 设置UI界面相关
extension OAuthViewController{
    func setupNavigationBar(){
 
    //设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action:#selector(OAuthViewController.closeItemAction))
        
        //设置右侧item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: UIBarButtonItemStyle.plain, target: self, action: #selector(OAuthViewController.fillItemAction))
        //设置标题
    title = "登录页面"
    }
    func loadPage(){
    let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirext_url)"
        //创建对应的NSURL
        guard let url = NSURL(string:urlString) else {
            return
        }
        //创建nsurlrequest
        let request = NSURLRequest(url: url as URL)
        webView.loadRequest(request as URLRequest)
    
    }
    


}
//MARK:- 事件监听事件
extension OAuthViewController{
    @objc  func closeItemAction(){
    dismiss(animated: true, completion: nil)
    }

    @objc  func fillItemAction(){
LMLog(message: "填充")
        //书写js代码 : javascript / java --->雷锋和雷峰塔的区别
        let jsCode = "document.getElementById('userId').value = '18203617850m0@sina.cn';document.getElementById('passwd').value = 'miss2011306'"
        //执行js代码
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }

}

//MARK:- webView delegate
extension OAuthViewController:UIWebViewDelegate{
    //开始加载
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    //加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    //加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    //当加载某一个网页时,会执行该方法
    //返回值 true-->继续加载该页面 false -->不会加载该页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        LMLog(message: request.url)
        //获取加载网页的url
        guard   let url = request.url else{
        return true
        }
        //获取url中的字符串
     let urlString =   url.absoluteString
        //判断该字符串中是否包含code
        guard urlString.contains("code=")else{
        return true
        }
        //将code截取出来
    let code = urlString.components(separatedBy: "code=").last!
        LMLog(message: urlString)
       LMLog(message: code)
        //请求accessToken
        loadAccessToken(code: code)
        return false
    }

}


//请求数据
extension OAuthViewController{
    func loadAccessToken(code:String){
          let urlString = "https://api.weibo.com/oauth2/access_token"
        //获取请求的参数
        let parameters = ["client_id":app_key,"client_secret":app_secre,"grant_type":"authorization_code","code":code,"redirect_uri":redirext_url]
        NetWorkingTools.shareInstace.request(methodType: .POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            if error != nil{
                LMLog(message: error)
                return;
            }
            LMLog(message: result)
            guard let accountDic = result else{
            LMLog(message: "没有获取授权后的数据")
                return
            }
            let account = UserAccount(dict: accountDic as! [String : AnyObject])
            LMLog(message: account)
            //请求用户信息
           self.loadUserInfo(account: account)
            
        }
}
    //请求用户信息
    func loadUserInfo(account:UserAccount){
        //获取accessToken
        guard let accessToken = account.access_token else{
        return
        }
        //获取uid
        guard let uid = account.uid else{
            return
        }
        //获取请求url
        let urlString = "https://api.weibo.com/2/users/show.json"
        //获取请求的参数
        let parameters = ["access_token":accessToken,"uid" :uid]
    NetWorkingTools.shareInstace.request(methodType: .GET, urlString: urlString, parameters: parameters as [String : AnyObject] ) { (result, error) in
        if error != nil{
        return
        }
        //拿到用户信息
        guard   let userInfoDic = result else{
        return
        }
        //从字典里取出昵称和头像
        account.screen_name = userInfoDic["screen_name"]  as? String
        account.avatar_large = userInfoDic["avatar_large"] as? String
        
        //将account对象保存
        
//        //获取沙盒路径
//        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).first!
//     let path =    (accountPath as NSString).strings(byAppendingPaths: ["data.plist"])
//        let path1=NSString.path(withComponents: path)
        //保存对象
        NSKeyedArchiver.archiveRootObject(account, toFile: UserAccounViewModel.shareIntace.accoutPath)
//        LMLog(message: path)
//        LMLog(message: result);
        //将account设置到单例对象中
        UserAccounViewModel.shareIntace.account = account
        //显示欢迎界面
       self.dismiss(animated: false, completion: {
            UIApplication.shared.keyWindow?.rootViewController = WelcomeViewController()
        })
        
        
        }
    
    }
    
    
}














































