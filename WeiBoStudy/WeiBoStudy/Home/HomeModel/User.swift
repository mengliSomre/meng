//
//  User.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/9/4.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class User: NSObject {

    //MARK:- 属性
    
    var profile_image_url :String?//用户头像
    var screen_name : String?//用户昵称
    //认证类型
    var verified_type : Int = -1    //会员等级
    var mbrank :Int = 0     
  
    
    //MARK:- 自定义构造函数
    init(dict:[String : AnyObject]) {
        super.init()
         setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}































