//
//  ConstantPushTransitionController.swift
//  pairs-global
//
//  Created by muukii on 2/5/17.
//  Copyright © 2017 eure. All rights reserved.
//

import UIKit

public final class ConstantPushTransitionController: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
  
  public var shouldUseInteractionController: UIViewControllerInteractiveTransitioning? {
    if isInteractivePop {
      return self
    }
    return nil
  }
  
  public var forwardAnimation: Bool = true
  
  public var isInteractivePop: Bool = false
  
  public override init() {
    super.init()
    completionCurve = .easeOut
  }
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    let containerView = transitionContext.containerView
    
    let fromVC = transitionContext.viewController(forKey: .from)!
    let toVC = transitionContext.viewController(forKey: .to)!
    
    if forwardAnimation {
      
      toVC.view.frame = transitionContext.finalFrame(for: toVC)
      
      guard transitionContext.isAnimated == true else {
        
        containerView.addSubview(toVC.view)
        transitionContext.completeTransition(true)
        return
      }
      
      containerView.addSubview(toVC.view)
//      toVC.view.transform = .init(translationX: toVC.view.bounds.width, y: 0)
      toVC.view.alpha = 0.1
      
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
        
//        toVC.view.transform = .identity
        toVC.view.alpha = 1
//        fromVC.view.transform = .init(translationX: -fromVC.view.bounds.width, y: 0)
        fromVC.view.alpha = 0.1
        
      }, completion: { (finish) in
        
        fromVC.view.alpha = 1
//        fromVC.view.transform = .identity
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
      
    } else {
      
      guard transitionContext.isAnimated == true else {
        
        fromVC.view.removeFromSuperview()
        transitionContext.completeTransition(true)
        return
      }
      
//      containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
      
//      toVC.view.transform = .init(translationX: -fromVC.view.bounds.width, y: 0)
      toVC.view.alpha = 0.1
      
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
        
        //          toVC.view.transform = .identity
        toVC.view.alpha = 1
        
        //          fromVC.view.transform = .init(translationX: fromVC.view.bounds.width, y: 0)
        fromVC.view.alpha = 0.1
        
      }, completion: { (finish) in
        
        if !transitionContext.transitionWasCancelled {
          fromVC.view.removeFromSuperview()
        }
        fromVC.view.alpha = 1
        
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
      
    }
  }
}
