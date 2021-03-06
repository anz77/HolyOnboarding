//
//  ViewController.swift
//  HolyOnboardingExamples
//
//  Created by ANDRII ZUIOK on 13.07.2021.
//

import UIKit
import HolyOnboarding

class ViewController: UIViewController {
    
    lazy var navControllerOnboarding: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SHOW WITH NAVIGATION CONTROLLER", for: .normal)
        button.addTarget(self, action: #selector(showNavControllerOnboarding(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var customAnimationOnboarding: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SHOW WITH CUSTOM ANIMATION", for: .normal)
        button.addTarget(self, action: #selector(showcustomAnimationOnboarding(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        view.addSubview(navControllerOnboarding)
        NSLayoutConstraint.activate([
            navControllerOnboarding.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navControllerOnboarding.heightAnchor.constraint(equalToConstant: 70),
            navControllerOnboarding.widthAnchor.constraint(equalToConstant: view.bounds.width),
            navControllerOnboarding.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        ])
        
        view.addSubview(customAnimationOnboarding)
        NSLayoutConstraint.activate([
            customAnimationOnboarding.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customAnimationOnboarding.heightAnchor.constraint(equalToConstant: 70),
            customAnimationOnboarding.widthAnchor.constraint(equalToConstant: view.bounds.width),
            customAnimationOnboarding.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        ])
    }
    
    @objc func showNavControllerOnboarding(_ sender: UIControl) {
        showNawOnboarding()
    }
    
    @objc func showcustomAnimationOnboarding(_ sender: UIControl) {
        showCustomOnboarding()
    }
    
    func showNawOnboarding() {
        
        let source = ExampleRemoteSource()
        
        source.getModelsFromRemoteConfig(key: "") { [weak self] (models: [ExampleOnboardingScreen]) in
            
            let container = HolyDefaultNavigationStackController<ExampleOnboardingScreen, ExampleOnboardingFabric>(onboardingFlow: models, fabric: ExampleOnboardingFabric())
            
            let pageControl = UIPageControl()
            container.pageControl = pageControl
            
            container.makeIAPController = { [weak container] in
                let iapController = ExampleIAPController()
                iapController.finished = { [weak container] in
                    container?.finishOnboarding?()
                }
                iapController.goPrevious = { [weak container] in
                    container?.goPrevious()
                }
                return iapController
            }
            
            container.showIDFA = {}

            container.finishOnboarding = { [weak container] in
                container?.dismiss(animated: true, completion: {})
            }
                        
            container.modalPresentationStyle = .automatic
            container.modalTransitionStyle = .coverVertical
            self?.present(container, animated: true) {}
        }
    }
    
    
    func showCustomOnboarding() {
        
        let source = ExampleRemoteSource()
        
        source.getModelsFromRemoteConfig(key: "") { [weak self] (models: [ExampleOnboardingScreen]) in
            
            let container = HolyCustomAnimatedContainerController<ExampleOnboardingScreen, ExampleOnboardingFabric>(onboardingFlow: models, fabric: ExampleOnboardingFabric())
            
            let pageControl = UIPageControl()
            container.pageControl = pageControl
            
            container.makeIAPController = { [weak container] in

                let iapController = ExampleIAPController()
                iapController.finished = { [weak container] in
                    container?.finishOnboarding?()
                }
                iapController.goPrevious = { [weak container] in
                    container?.goPrevious()
                }
                return iapController
            }
            
            container.showIDFA = {}
            
            container.finishOnboarding = { [weak container] in
                container?.dismiss(animated: true, completion: {})
            }
            
            container.modalPresentationStyle = .automatic
            container.modalTransitionStyle = .coverVertical
            self?.present(container, animated: true) {}
        }
    }

}

