//
//  LMPresentationController.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/8/28.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class LMPresentationController: UIPresentationController {
    //Mark:- 对外提供一个属性
    var presentedFrame : CGRect = CGRect.init()
    
    lazy var coverView:UIView = UIView()
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        //改变弹出View的尺寸
        presentedView?.frame = presentedFrame        //添加模板
        setupCoverView()
    }
    
    
}

//MARK:- 设置UI界面相关
extension LMPresentationController{
    func setupCoverView(){
    //添加蒙版
        containerView?.insertSubview(coverView, at: 0)
        //设置蒙版的属性
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = containerView!.bounds
        //添加手势 
        let tab  = UITapGestureRecognizer(target: self, action: #selector(LMPresentationController.coverViewClick))
        coverView.addGestureRecognizer(tab)
        
    
    }

}

//MARK:- 事件监听
extension LMPresentationController{
    @objc func coverViewClick(){
    LMLog(message: "coverViewClick")
        presentedViewController.dismiss(animated: true, completion: nil)
    }

}
































