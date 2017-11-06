//
//  UIBarButtonItem+Extension.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/8/25.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
    /*
    convenience init(imageName:String) {
        self.init()
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        btn.setImage(UIImage.init(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        btn.sizeToFit()
        self.customView = btn
    }
*/
    convenience init(imageName:String){
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        btn.setImage(UIImage.init(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        btn.sizeToFit()
    self.init(customView: btn)
    }

}
