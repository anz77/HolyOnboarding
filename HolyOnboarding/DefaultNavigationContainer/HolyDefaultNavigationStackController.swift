//
//  HolyDefaultNavigationStackController.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 15.07.2021.
//

import UIKit

open class HolyDefaultNavigationStackController<T: HolyRawRepresentableControllerMaker>: UIViewController, HolyOnboardingNavigationStackProtocol {
    
    open var navigation = UINavigationController()
    open var pageControl: UIPageControl?
    public var environmentValues: [String : Any] = [:]
    public var onboardingFlow: [T] = []
    open var currentIndex = 0
    weak public var analyticsHandler: OnboardingAnalyticsHandler?
        
    public var showIDFA: (()->())?
    public var makeIAPController: (()->UIViewController)?
    public var finishOnboarding: (()->())?
    
    public init(onboardingFlow: [T] = []) {
        self.onboardingFlow = onboardingFlow
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        currentIndex = 0
        start()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showIDFA?()
    }
    
    public func setupUI() {
        configureNavigationController()
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
        let index = currentIndex + 1
        if let controller = controller(for: index) {
            navigation.pushViewController(controller, animated: true)
            currentIndex = index
            pageControl?.currentPage = currentIndex
        } else {
            if let iapController = makeIAPController {
                navigation.pushViewController(iapController(), animated: true)
                currentIndex = index
                pageControl?.currentPage = currentIndex
            } else {
                finishOnboarding?()
            }
        }
        print("i'm here, index = \(currentIndex)")

    }
    
    public func goPrevious() {
        let index = currentIndex - 1
        navigation.popViewController(animated: true)
        currentIndex = index
        pageControl?.currentPage = currentIndex
        print("i'm here, index = \(currentIndex)")
    }
    
    public func sendAnalyticEvent(key: String, values: [String : Any]) {
        analyticsHandler?.sendAnalyticEvent(key: key, values: values)
    }
    
    public func sendAnalyticEvent(key: String, value: Any) {
        analyticsHandler?.sendAnalyticEvent(key: key, value: value)
    }
    
    public func configureNavigationController() {
        view.addSubview(navigation.view)
        addChild(navigation)
        navigation.didMove(toParent: self)
        navigation.view.frame = view.bounds
        
        navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigation.navigationBar.shadowImage = UIImage()
        navigation.navigationBar.isTranslucent = true
        navigation.navigationBar.tintColor = .white
        navigation.view.backgroundColor = UIColor.clear
        navigation.setNavigationBarHidden(true, animated: true)
    }
    
    public func controller(for index: Int) -> HolyOnboardingItem? {
        guard index >= 0 && index < onboardingFlow.count else {return nil}
        let controller = onboardingFlow[index].getController(coordinator: self)
        controller.isInitial = (index == 0)
        controller.isFinal = (index == onboardingFlow.count - 1 + (makeIAPController == nil ? 0 : 1))
        return controller
    }
    
    public func start() {
        currentIndex = 0
        guard let controller = controller(for: currentIndex) else { return }
        navigation.pushViewController(controller, animated: true)
        pageControl?.currentPage = currentIndex
    }
    
    open func appendController(_ controller: UIViewController) {
        navigation.pushViewController(controller, animated: true)
    }
    
}