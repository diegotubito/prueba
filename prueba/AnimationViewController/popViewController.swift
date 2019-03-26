//
//  popViewController.swift
//  prueba
//
//  Created by David Diego Gomez on 25/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

class popAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    var dismissCompletion : (()->Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let toView = transitionContext.view(forKey: .to)!
        
        containerView.addSubview(toView)
        toView.alpha = 0.0
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 10, initialSpringVelocity: 0.0,
                       animations: {
                        toView.alpha = 1.0
        }, completion: { _ in
            
            if !self.presenting {
                self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        })
    }
    
    
}
