//
//    AppDelegate.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/8/22.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var defaultViewController:UIViewController?{
        let isLogin = UserAccounViewModel.shareIntace.isLogin()
        return isLogin ? WelcomeViewController():UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //创建全局颜色
        UITabBar.appearance().tintColor = UIColor.orange
        UINavigationBar.appearance().tintColor = UIColor.orange
//     //创建window
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController = defaultViewController;
//
       window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
      
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
     
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
     
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

func LMLog<T>(message:T,file:String = #file,funcName:String = #function,lineNum:Int = #line){
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("\(fileName):(\(lineNum))-\(message)")
    
    #endif
}



















