//
//  ComposeTextView.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/9/15.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {
    //MARK:- 懒加载
    lazy var placeHolderLabel:UILabel = UILabel()
    //MARK:- 构造函数
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
 

}


extension ComposeTextView{

    func setupUI(){
    //添加子控件
        addSubview(placeHolderLabel)
        //设置frame
        placeHolderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(10)
        }
        //设置属性
        placeHolderLabel.textColor = UIColor.lightGray
placeHolderLabel.font = font
        //设置文字
        placeHolderLabel.text = "分享新鲜事..."
        //设置内容内边距
        textContainerInset = UIEdgeInsetsMake(5,7, 0, 7)
    
    }



}























