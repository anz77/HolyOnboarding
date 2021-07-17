//
//  FirstExampleOnboardigScreen.swift
//  HolyOnboardingExamples
//
//  Created by ANDRII ZUIOK on 14.07.2021.
//

import UIKit
import HolyOnboarding

class FirstExampleOnboardigScreen: UIViewController, HolyOnboardingItem {
    
    var color: UIColor
    var titleString: String
    
    init(color: UIColor, titleString: String) {
        self.color = color
        self.titleString = titleString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleString
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
        setupUI()
    }
    
    func setupUI() {
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.widthAnchor.constraint(equalToConstant: 70),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200)
        ])
        
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

