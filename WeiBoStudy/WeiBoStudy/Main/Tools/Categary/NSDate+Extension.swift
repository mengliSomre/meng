//
//  NSDate+Extension.swift
//  时间处理
//
//  Created by XYJ on 2017/9/4.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import Foundation


extension NSDate{
    class func createDateString(creatTime:String)->String {
//        let creatTime = "Mon Sep 04 16:29:41 +0800 2017"
        //创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = NSLocale(localeIdentifier: "en") as Locale!
        //将字符串时间转成NSDate
        guard let createDate = fmt.date(from: creatTime) else {
            return ""
        }
//        print(createDate)
        // 创建当前时间
        let nowDate = NSDate()
        //计算创建时间和当前时间的时间差
        let interval = Int(nowDate.timeIntervalSince(createDate))
//        print(interval)
        //对时间进行处理
        //显示刚刚
        if interval < 60{
//            print("刚刚")
            return "刚刚"
        }
        //59分钟钱
        if interval < 60 * 60 {
//            print("\(interval/60)分钟前")
            return "\(interval/60)分钟前"
        }
        //1小时前
        if interval < 60*60*24 {
//            print("\(interval/(60*60))小时前")
            return "\(interval/(60*60))小时前"
        }
        //创建日历对象
        let calendar = NSCalendar.current
        //处理昨天的数据
        if calendar.isDateInYesterday(createDate){
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: createDate)
//            print(timeStr)
            
            return timeStr
        }
        //处理一年之内
        let cmp = calendar.dateComponents([Calendar.Component.year], from: createDate, to: nowDate as Date)
        if cmp.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: createDate)
//            print(timeStr)
            return timeStr
        }
        //处理超过一年
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: createDate)
//        print(timeStr)
        
   return timeStr
    }


}
