//
//  TitleButton.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/8/25.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
//MARK:- 重写init函数
    override init(frame: CGRect) {
        super.init(frame:frame)
        setImage(UIImage.init(named: "navigationbar_arrow_down"), for: UIControlState.normal)
        setImage(UIImage.init(named: "navigationbar_arrow_up"), for: UIControlState.selected)
//        setTitle("皮卡丘BiuBiuBiu", for: UIControlState.normal)
        
        setTitleColor(UIColor.black, for: UIControlState.normal)
        sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 10
        
    }
    
    //swift中规定:重写空间的init(frame方法)或者init()方法必须重写下面的方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
