//
//  ViewController.swift
//  HolyOnboardingExamples
//
//  Created by ANDRII ZUIOK on 13.07.2021.
//

import UIKit
import HolyOnboarding

class ViewController: UIViewController {
    
    lazy var onboardingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SHOW ONBAORDING", for: .normal)
        button.addTarget(self, action: #selector(show(_:)), for: .touchUpInside)
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
        view.addSubview(onboardingButton)
        NSLayoutConstraint.activate([
            onboardingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingButton.heightAnchor.constraint(equalToConstant: 70),
            onboardingButton.widthAnchor.constraint(equalToConstant: 250),
            onboardingButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
    }
    
    @objc func show(_ sender: UIControl) {
        showOnboarding()
    }
    
    func showOnboarding() {
        let onbaordingFlow: [ExampleOnboardingScreens] = [.three, .one, .two]
        
        //let container = HolyDefaultNavigationStackController(onboardingFlow: onbaordingFlow)
        let container = HolyCustomAnimatedContainerController(onboardingFlow: onbaordingFlow)
        
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
        
        container.finishOnboarding = { [weak container] in
            container?.dismiss(animated: true, completion: {})
        }
 
        container.modalPresentationStyle = .automatic
        container.modalTransitionStyle = .coverVertical
        present(container, animated: true) {}
    }


}

