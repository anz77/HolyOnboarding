//
//  HolyDefaultContainerController.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 13.07.2021.
//

import UIKit

open class HolyCustomAnimatedContainerController<T: HolyRawRepresentableControllerMaker>: UIViewController, HolyOnboardingCustomStackProtocol {
    
    public func makeControllers() {
        controllers = (0..<onboardingFlow.count).compactMap { index in
            let controller = onboardingFlow[index].getController(coordinator: self)
            controller.isInitial = (index == 0)
            controller.isFinal = (index == onboardingFlow.count - 1 + (makeIAPController == nil ? 0 : 1))
            return controller
        }
        
        if let iapController = makeIAPController {
            controllers.append(iapController())
        }
    }
    
    public var finishOnboarding: (()->())?
    
    public var makeIAPController: (() -> UIViewController)?
    
    lazy var container: UIView = UIView()
    
    open var pageControl: UIPageControl?
    
    weak public var analyticsHandler: OnboardingAnalyticsHandler?
    
    public var showIDFA: (()->())?
        
    open var currentIndex: Int = 0
    open var selectedViewController: UIViewController?
    open var environmentValues: [String: Any] = [:]
    
    open var onboardingFlow: [T] = []
    open var controllers: [UIViewController] = []
    
    public init(onboardingFlow: [T] = []) {
        self.onboardingFlow = onboardingFlow
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeControllers()
        currentIndex = 0
        setupUI()
        if let firstController = controllers.first {
            setupController(controller: firstController)
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .red
    }
    
    open func setupUI() {
        view.addSubview(container)
        container.frame = view.bounds
        setupPageControl()
    }
    
    func setupPageControl() {
        if let pageControl = pageControl {
            pageControl.currentPage = currentIndex
            pageControl.numberOfPages = onboardingFlow.count + (makeIAPController == nil ? 0 : 1)
            view.addSubview(pageControl)
            pageControl.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height * 0.1)
            pageControl.frame.origin = CGPoint(x: 0, y: view.bounds.height * 0.84)
        }
    }
    
    public func goNext() {
        if !controllers.isEmpty && (currentIndex < controllers.count - 1) {
            currentIndex += 1
            transition(fromViewController: selectedViewController, toViewController: controllers[currentIndex])
            selectedViewController = controllers[currentIndex]
            pageControl?.currentPage = currentIndex
        } else {
            finishOnboarding?()
        }
        print("i'm here, index = \(currentIndex)")
    }
    
    public func goPrevious() {
        if !controllers.isEmpty && (currentIndex > 0) {
            currentIndex -= 1
            transition(fromViewController: selectedViewController, toViewController: controllers[currentIndex])
            selectedViewController = controllers[currentIndex]
            pageControl?.currentPage = currentIndex
        }
        print("i'm here, index = \(currentIndex)")
    }
 
    open func setupController(controller: UIViewController) {
        container.addSubview(controller.view)
        controller.willMove(toParent: self)
        addChild(controller)
        controller.view.frame = container.bounds
        selectedViewController = controller
    }
    
    open func transition(fromViewController: UIViewController?, toViewController: UIViewController?) {
        
        guard self.controllers.count > 0, let toViewController = toViewController, let toIndex = controllers.firstIndex(where: { $0 == toViewController })  else {return}
        guard let fromViewController = fromViewController, let fromIndex = controllers.firstIndex(where: { $0 == fromViewController }) else {
            container.addSubview(toViewController.view)
            toViewController.willMove(toParent: self)
            addChild(toViewController)
            toViewController.view.frame = container.bounds
            return
        }
        
        container.addSubview(toViewController.view)
        addChild(toViewController)
        toViewController.view.frame = container.bounds
        
        fromViewController.willMove(toParent: nil)

        let animator = PrivateAnimationTransition()
        let transitionContext = PrivateTransitionContext(containerView: self.container, fromViewController: fromViewController, toViewController: toViewController, goingRight: toIndex > fromIndex)
        transitionContext.isAnimated = true
        transitionContext.isInteractive = false
        transitionContext.completionBlock = { didComplete in
            fromViewController.view.removeFromSuperview()
            fromViewController.removeFromParent()
            toViewController.didMove(toParent: self)
            //animator.animationEnded?(didComplete)
        }
        animator.animateTransition(using: transitionContext)
    }
    
    open func appendController(_ controller: UIViewController) {
        if controllers.count > onboardingFlow.count {
            controllers.removeLast()
        }
        controllers.append(controller)
        transition(fromViewController: controllers[currentIndex], toViewController: controller)
    }
    
    public func sendAnalyticEvent(key: String, values: [String : Any]) {
        analyticsHandler?.sendAnalyticEvent(key: key, values: values)
    }
    
    public func sendAnalyticEvent(key: String, value: Any) {
        analyticsHandler?.sendAnalyticEvent(key: key, value: value)
    }
    
}

