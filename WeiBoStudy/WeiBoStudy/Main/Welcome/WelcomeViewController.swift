//
//  WelcomeViewController.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/9/2.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
//MARK:- 脱线的属性
    @IBOutlet weak var iconViewVottomCons: NSLayoutConstraint!
    
    @IBOutlet weak var icoImage: UIImageView!
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置头像
        let proFileUrl = UserAccounViewModel.shareIntace.account?.avatar_large
        //??: 如果??前面的可选类型有值,那么将前面的可选类型进行解包并赋值
        //如果??前面的可选类型为nil那么直接使用??后面的值
        let url = NSURL(string: proFileUrl ?? "")
        icoImage.sd_setImage(with: url! as URL, placeholderImage: UIImage.init(named: "avatar_default_big"))
//改变约束的位置
        iconViewVottomCons.constant = UIScreen.main.bounds.height/2
        //执行动画
        //Damping 阻力系数越大,谭东效果越不明显 0-1
        //initialSpringVelocity :初始化速度
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
           UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
        
        
    }

}


    
    
    
    
    
    
    
    
    
    
    
    
































