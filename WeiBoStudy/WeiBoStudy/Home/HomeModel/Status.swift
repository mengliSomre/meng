//
//  Status.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/9/4.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class Status: NSObject {
//MARK:- 属性
     //微博创建时间
    var created_at :String?    //微博来源
    var source :String?
    var text:String?//微博正文
    var  mid:Int = 0//微博ID
    var user :User?//微博对应的用户
    var pic_urls :[[String :String]]?//微博配图
    var retweeted_status:Status? //微博对应转发的微博
    
    
    
    //MARK:- 自定义构造函数
    init(dict:[String : AnyObject]) {
        super .init()
        setValuesForKeys(dict)
        
        //将用户字典转成用户模型对象
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = User(dict: userDict)
        }
        //将转发微博字典转成用户模型对象
        if let retweeted = dict["retweeted_status"] as? [String : AnyObject] {
            retweeted_status = Status(dict: retweeted)
        }
        
        
        
        
        
        
        
        
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
