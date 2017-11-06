//
//  BaseViewController.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/8/24.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    //懒加载属性
    lazy var visitorView :VisitorView = VisitorView.VisitorView()
//定义变量
    var isLogin :Bool = UserAccounViewModel.shareIntace.isLogin()
    
    
    //系统回调函数
    override func loadView(){
//        //获取沙盒路径
//        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).first!
//        let path =    (accountPath as NSString).strings(byAppendingPaths: ["data.plist"])
//        let path1=NSString.path(withComponents: path)
//        //读取信息
//        let account = NSKeyedUnarchiver.unarchiveObject(withFile: path1) as? UserAccount
//        if let account = account {
//            //取出过期日期:与当前日期进行对比
//            if let expires_date = account.expires_date {
//            isLogin = expires_date.compare(NSDate() as Date) == ComparisonResult.orderedDescending
//            }
//            
//            
//        }
       
        isLogin ? super.loadView() : steupVisitorView()
    
    }
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
LMLog(message: "\(UserAccounViewModel.shareIntace.accoutPath)")
  setupNavigationItems()
    }

 

}
//MARK:- 设置UI界面
extension BaseViewController{
    //设置访客视图
     func steupVisitorView(){
//    visitorView.backgroundColor = UIColor.red
        view = visitorView
        visitorView.registerBtn.addTarget(self, action: #selector(BaseViewController.registerBtnClick), for: UIControlEvents.touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(BaseViewController.loginBtnClick), for: UIControlEvents.touchUpInside)
        
    }
    //设置导航栏左右的item
    func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseViewController.registerBtnClick))
         navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseViewController.loginBtnClick))
        
    }
    

}


//事件监听
extension BaseViewController{
    @objc  func registerBtnClick(){
    LMLog(message: "注册")
    }
    @objc  func loginBtnClick(){
        LMLog(message: "登录")
        //创建授权控制器
        let oauthVC = OAuthViewController()
        //包装一个导航控制器
        let oauthNaV = UINavigationController(rootViewController: oauthVC)
        //弹出控制器
        present(oauthNaV, animated: true, completion: nil)
        
    }
}


























