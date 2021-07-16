//
//  PrivateAnimationTransition.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 15.07.2021.
//

import UIKit

open class PrivateAnimationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let kChildViewPadding: CGFloat = 0.0//16.0
    let kDamping: CGFloat = 1.0//0.75
    let kInitialSpringVelocity: CGFloat = 0.0//0.5
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { return 1.0 }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to), let fromViewController = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        let goingRight: Bool = transitionContext.initialFrame(for: toViewController).origin.x < transitionContext.initialFrame(for: fromViewController).origin.x
        
        let travelDistance: CGFloat = transitionContext.containerView.bounds.size.width + kChildViewPadding
        
        let travel: CGAffineTransform = CGAffineTransform(translationX: goingRight ? travelDistance : -travelDistance, y: 0.0)
        //transitionContext.containerView.addSubview(toViewController.view)
        //toViewController.view.alpha = 0.0
        toViewController.view.transform = travel.inverted()
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: kDamping, initialSpringVelocity: kInitialSpringVelocity, options: []) {
            fromViewController.view.transform = travel
            //fromViewController.view.alpha = 0.0
            toViewController.view.transform = CGAffineTransform.identity
            toViewController.view.alpha = 1.0
        } completion: { finished in
            fromViewController.view.transform = .identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

    }
    
}
