//
//  UserAccountTool.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/9/2.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class UserAccounViewModel {
    //MARK:- 将类设计成单例
    static let shareIntace:UserAccounViewModel = UserAccounViewModel()
    
    //Mark:- 定义属性
    var account:UserAccount?
    
    //MARK:- 计算属性
    var accoutPath:String{
           //获取沙盒路径
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).first!
        let path =    (accountPath as NSString).strings(byAppendingPaths: ["data.plist"])
        
      return  NSString.path(withComponents: path)

    }
    
    
    //MARK:- 重写init属性
    init() {
        //读取信息
      account = NSKeyedUnarchiver.unarchiveObject(withFile: accoutPath) as? UserAccount
       
    }
    func isLogin() -> Bool{
        if account == nil {
            return false
        }
        guard let expireDate = account?.expires_date else {
            return false
        }
        
        return expireDate.compare(NSDate() as Date) == ComparisonResult.orderedDescending
        
        
    }
    
    
    
}
