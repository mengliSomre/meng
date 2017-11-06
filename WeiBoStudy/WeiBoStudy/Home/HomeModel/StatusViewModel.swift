//
//  StatusViewModel.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/9/6.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {
//Mark:- 定义属性
     var cellHeight :CGFloat = 0
    var status:Status?
   
    
    //MARK:- 对数据处理的属性
    var sourceText : String?//处理来源
    var creatText  :String?//处理创建时间
    //MARK:- 对用户数据处理
    var verifiedImage : UIImage?//处理用户认证图表
    var vipImage : UIImage?//处理用户会员等级
    var icoUrl :NSURL?//处理用户头像地址
    var picUrls :[NSURL] = [NSURL]()//处理微博配图属性
 
    
    //MARK:- 定义构造函数
    init(status:Status) {
        self.status = status
        //对来源进行处理
    
        
        if let source = status.source, source != ""  {
            //对来源的字符串进行处理
            //获取起始位置和截取的长度
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            //截取字符串
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
           //处理时间
         if let creatAt = status.created_at{
              creatText = NSDate.createDateString(creatTime: creatAt)
        }
        
        //处理认证
        let verifiedtype = status.user?.verified_type ?? -1
        
            switch verifiedtype {
            case 0:
                verifiedImage = UIImage.init(named: "avatar_vip")
            case 2,3,5:
                verifiedImage = UIImage.init(named: "avatar_enterprise_vip")
            case 200:
                verifiedImage = UIImage.init(named: "avatar_grassroot")
            default:
                verifiedImage = nil
            }

        //处理会员等级
        
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank<6 {
             vipImage = UIImage.init(named: "common_icon_membership_level\(mbrank)")
        }
        
       //处理用户头像
        let icoUrlString = status.user?.profile_image_url ?? ""
        icoUrl = NSURL(string: icoUrlString)
        //处理配图数据
        let picURLDicts = status.pic_urls?.count != 0 ? status.pic_urls : status.retweeted_status?.pic_urls
        if let picURLDicts = picURLDicts {
            for picurlDic in picURLDicts {
                guard   let picURLString = picurlDic["thumbnail_pic"] else{
                continue
                }
                picUrls.append(NSURL(string: picURLString)!)
            }
        }
        
        
        
        }
    

    
}
