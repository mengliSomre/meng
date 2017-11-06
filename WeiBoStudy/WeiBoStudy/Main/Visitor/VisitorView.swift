//
//  VisitorView.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/8/24.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class VisitorView: UIView {
//MARK:- 控件属性
    
    @IBOutlet weak var zpImage: UIImageView!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var promptLabel: UILabel!
    
    //MARK - 自定义函数
    func setupVistitorViewInfo(icoName:String,title:String) {
        logoImageView.image = UIImage.init(named: icoName)
        zpImage.isHidden = true
        promptLabel.text = title
    }
    
    func addRotationAnmin() {
        //1.创建旋转动画
//        CAKeyframeAnimation;
//        CABasicAnimation;
        
        let momAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
   
        
        momAnimation.fromValue = 0 //左幅度
        momAnimation.toValue = M_PI * 2//右幅度
        momAnimation.duration = 5
        momAnimation.repeatCount = MAXFLOAT //无限重复
        momAnimation.isRemovedOnCompletion = false
   zpImage.layer.add(momAnimation, forKey: nil)
    }
    
    
    
    
    
    
    
    
    
//MARK:- 提供快速创建通过xib创建的类方法
    class func VisitorView() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }
    
    
    

}
