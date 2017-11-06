//
//  ComposeView.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/9/15.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit
import SnapKit

class ComposeView: UIView {
    //MARK:-懒加载属性
    lazy var titleLabel : UILabel = UILabel()
    lazy var screenNameLabel:UILabel = UILabel()
    //MARK:- 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
//MARK:- 设置UI界面
extension ComposeView{
    func setupUI(){
    addSubview(titleLabel)
        addSubview(screenNameLabel)
//设置farme
    titleLabel.snp.makeConstraints { (make) in
        make.centerX.equalTo(self)
        make.top.equalTo(-20)
    }
    screenNameLabel.snp.makeConstraints { (make) in
        make.centerX.equalTo(titleLabel.snp.centerX)
        make.top.equalTo(titleLabel.snp.bottom).offset(3)
    }
    //设置控件属性
    titleLabel.font = UIFont.systemFont(ofSize: 16)
    screenNameLabel.font = UIFont.systemFont(ofSize: 14)
    screenNameLabel.textColor = UIColor.lightGray
    //设置文字内容
    titleLabel.text = "发布微博"
    screenNameLabel.text = UserAccounViewModel.shareIntace.account?.screen_name
    
    
    
    }
    
    
    


}














