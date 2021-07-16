//
//  FirstExampleOnboardigScreen.swift
//  HolyOnboardingExamples
//
//  Created by ANDRII ZUIOK on 14.07.2021.
//

import UIKit
import HolyOnboarding

class FirstExampleOnboardigScreen: UIViewController, HolyOnboardingItem {
    
    var isInitial: Bool = false
    var isFinal: Bool = false
    
    weak var coordinator: HolyOnboardingContainerProtocol?
    
    lazy var leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LEFT", for: .normal)
        button.addTarget(self, action: #selector(goLeft(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RIGHT", for: .normal)
        button.addTarget(self, action: #selector(goRight(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupUI()
    }
    
    func setupUI() {
        
        if !isInitial {
            view.addSubview(leftButton)
            NSLayoutConstraint.activate([
                leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                leftButton.heightAnchor.constraint(equalToConstant: 70),
                leftButton.widthAnchor.constraint(equalToConstant: 70),
                leftButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
            ])
        }
        
        if !isFinal {
            view.addSubview(rightButton)
            NSLayoutConstraint.activate([
                rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                rightButton.heightAnchor.constraint(equalToConstant: 70),
                rightButton.widthAnchor.constraint(equalToConstant: 70),
                rightButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
            ])
        }
        
    }
    
    @objc func goLeft(_ sender: UIButton) {
        coordinator?.goPrevious()
    }
    
    @objc func goRight(_ sender: UIButton) {
        coordinator?.goNext()
    }
    
    
}

