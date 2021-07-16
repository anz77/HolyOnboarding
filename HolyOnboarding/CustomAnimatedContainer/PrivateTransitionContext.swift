//
//  PrivateTransitionContext.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 15.07.2021.
//

import UIKit


open class PrivateTransitionContext: NSObject, UIViewControllerContextTransitioning {
    public var containerView: UIView
    public var presentationStyle: UIModalPresentationStyle
    public var isAnimated: Bool = true
    public var isInteractive: Bool = true
    public var transitionWasCancelled: Bool = false
    public func updateInteractiveTransition(_ percentComplete: CGFloat) {}
    public func finishInteractiveTransition() {}
    public func cancelInteractiveTransition() {}
    public func pauseInteractiveTransition() {}
    public func completeTransition(_ didComplete: Bool) {completionBlock?(didComplete)}
    public func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {privateViewControllers[key]}
    public func view(forKey key: UITransitionContextViewKey) -> UIView? { return nil }
    public var targetTransform: CGAffineTransform = .identity
    public func initialFrame(for vc: UIViewController) -> CGRect {
        (vc == viewController(forKey: .from)) ? self.privateDisappearingFromRect : self.privateAppearingFromRect
    }
    public func finalFrame(for vc: UIViewController) -> CGRect {
        (vc == viewController(forKey: .from)) ? self.privateDisappearingToRect : self.privateAppearingToRect
    }
    var completionBlock: ((Bool)->())?
    var privateViewControllers: [UITransitionContextViewControllerKey: UIViewController]
    var privateDisappearingFromRect: CGRect
    var privateAppearingFromRect: CGRect
    var privateDisappearingToRect: CGRect
    var privateAppearingToRect: CGRect
    
    init(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController, goingRight: Bool) {
        
        self.presentationStyle = .custom
        self.containerView = containerView
        self.privateViewControllers = [.from: fromViewController, .to: toViewController]
        let travelDistance = goingRight ? -(self.containerView.bounds.size.width) : self.containerView.bounds.size.width
        self.privateAppearingToRect = self.containerView.bounds
        self.privateDisappearingFromRect = self.containerView.bounds
        self.privateDisappearingToRect = self.containerView.bounds.offsetBy(dx: travelDistance, dy: 0)
        self.privateAppearingFromRect = self.containerView.bounds.offsetBy(dx: -travelDistance, dy: 0)
        super.init()
    }

}

