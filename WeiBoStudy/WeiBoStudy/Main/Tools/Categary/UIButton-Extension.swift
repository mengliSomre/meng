//
//  UIButton-Extension.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/8/23.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit
extension UIButton {
//swift中类方法是以class开头的方法类似于OC中+开头的方法
//    class func createrButton(imageName:String,bgImageName:String)->UIButton{
//    //创建btn
//        let btn = UIButton()
//        //设置btn属性
//        btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
//           btn.setImage(UIImage.init(named: imageName + "_highlighted"), for: UIControlState.highlighted)
//        btn.setBackgroundImage(UIImage.init(named: bgImageName), for: UIControlState.normal)
//           btn.setBackgroundImage(UIImage.init(named: bgImageName + "_highlighted"), for: UIControlState.highlighted)
//        btn.sizeToFit()
//        return btn
//    }
    //convenience 便利使用convenience修饰的构造函数叫做便利构造函数,
    //遍历构造函数通常用在对系统进行构造函数的扩充
    /*
     1.遍历构造函数通常都是卸载extension里面
     2.遍历构造函数init前面需要加载convenience
     3.在遍历构造函数中需要明确调用self.init
     
     */
    convenience init(imageName:String,bgImage:String) {
        self.init()
        setImage(UIImage.init(named: imageName), for: UIControlState.normal)
         setImage(UIImage.init(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        setBackgroundImage(UIImage.init(named: bgImage), for: UIControlState.normal)
        setBackgroundImage(UIImage.init(named: bgImage + "_highlighted"), for: UIControlState.highlighted)
        sizeToFit()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
