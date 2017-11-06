//
//  PopoverAnimator.swift
//  WeiBoStudy
//
//  Created by XYJ on 2017/8/28.
//  Copyright © 2017年 海角七梦. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    //MARK:- 对外提供的属性
    //MARK:- 属性
    var isPresented :Bool = false
    var presententedFrame : CGRect = CGRect.init()
    
    var callBack :((_ presented : Bool) ->())?
//    init(callBack :  @escaping ( presented:Bool)->()) {
//        self.callBack = callBack
////    }
//   init(callback:@escaping (_ presented:Bool)->()) {
//        self.callBack = callback
//    }
    
    
}
//MARK:- 自定义转场代理方法
extension PopoverAnimator:UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentation = LMPresentationController(presentedViewController: presented, presenting: presenting)
        presentation.presentedFrame = presententedFrame
        return presentation
    }
    //自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        callBack!(isPresented)
        return self
    }
    //自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
            callBack!(isPresented)
        return self;
    }
    
}

//MARK:- 弹出和消失动画代理的方法

extension PopoverAnimator:UIViewControllerAnimatedTransitioning{
    //动画执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    //获取转场的上下文,可以通过转场上下文获取弹出View和消失view
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //获取弹出的View
        isPresented ? animationForPresententedView(transitionContext: transitionContext) : animationDismissedView(transitionContext: transitionContext)
        
    }
    //自定义弹出动画
    func animationForPresententedView(transitionContext: UIViewControllerContextTransitioning){
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        //将弹出的View添加到containerView中
        transitionContext.containerView.addSubview(presentedView!)
        //执行动画
        presentedView?.transform = CGAffineTransform(scaleX: 1.0,y: 0.0)
        presentedView?.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0)
        UIView.animate(withDuration:transitionDuration(using: transitionContext), animations: {
            presentedView?.transform = CGAffineTransform.identity
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        
        
    }
    //自定义消失动画
    func animationDismissedView(transitionContext: UIViewControllerContextTransitioning){
        let dismisView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        transitionContext.containerView.addSubview(dismisView!)
        //执行动画
        dismisView?.transform = CGAffineTransform(scaleX: 1.0,y: 0.00001)
        //        dismisView?.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0)
        //执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismisView?.removeFromSuperview()
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        
        
    }
    
    
}
