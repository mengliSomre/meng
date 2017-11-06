//
//  MainViewController.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/8/22.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
// private lazy var composeBtn : UIButton = UIButton.createrButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
private lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImage: "tabbar_compose_button")
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //遍历所有的item
        for i in 0..<tabBar.items!.count{
            //获取item
            let item = tabBar.items![i]
            //如果下标是2则该item不可以与用户交互
            if i == 2 {
                item.isEnabled = false
                continue
            }
        
            //设置其他item的选中时候的图片
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//MainViewController.setUpUI()
        //1.将composeBtn添加到tabbar中
        tabBar.addSubview(composeBtn)
        //2.设置监听
        //Selector 1>Selector("")2>""
        composeBtn.addTarget(self, action: #selector(MainViewController.composeBtnAction), for: UIControlEvents.touchUpInside)

        //设置位置
        composeBtn.center = CGPoint.init(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        
//addChildViewController(childVcName: "HomeViewController", title: "首页", imageName: "tabbar_home")
//        addChildViewController(childVcName: "MessageViewController", title: "消息", imageName: "tabbar_message_center")
//        addChildViewController(childVcName: "DiscoverViewController", title: "发现", imageName: "tabbar_discover")
//        addChildViewController(childVcName: "ProfileViewController", title: "我", imageName: "tabbar_profile")
//    //获取json文件路径
//        guard    let jsonPath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil)else{
//        LMLog(message: "没有获取到对应的json文件")
//        return
//        }
//        //读取json文件中的内容
//        guard let jsonData = NSData(contentsOfFile:jsonPath) else {
//            LMLog(message: "没有渠道json文件中的数据")
//            return
//        }
//        
//        //将data转成数组
//        guard   let dicArray = try?JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions) else{
//        return
//        }
        
        
     
   
    }
    //swift支持方法的重载
    //方法的重载,方法名相同,但是参数不同 -->参数类型不同 参数个数不同
    //private 在当前文件中可以访问,但是其他文件不能访问
   private func addChildViewController(childVcName:String,title:String,imageName:String){
    //0.获取命名空间
    guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else{
    print("没有获取到命名空间")
        return
    }
    //1.根据字符串获取对应的class
    guard let ChildVcClass = NSClassFromString(nameSpace + "." + childVcName) else {
        LMLog(message: "没有获取到对应的class")
        return
    }
    //2.将对应的AnyObject转成控制器的类型 
    guard let childType = ChildVcClass as? UIViewController.Type else {
        LMLog(message: "没有获取到对应的控制器类型")
        return
    }
    
    //3.创建对应的控制器对象
    let childVc  = childType.init()
    
    
    LMLog(message: "获取到对应的class")
    
    
//    //创建子控制器
//   
    childVc.title = title
    childVc.tabBarItem.image = UIImage(named:imageName)
            childVc.tabBarItem.selectedImage = UIImage(named:imageName + "_highlighted")
    
    //设置子控制器的属性
    let childNav = UINavigationController(rootViewController:childVc)
    addChildViewController(childNav)
//    }

    }



}

extension MainViewController{
    func composeBtnAction()  {
        LMLog(message: "composeBtnAction")
        //创建发布控制器
        let composeVC = ComposeViewController()
        //创建导航栏控制器
        let composeNC  = UINavigationController.init(rootViewController: composeVC)
        //弹出
        present(composeNC, animated: true, completion: nil)
        
        
        
    }
  
    
    
    
}




