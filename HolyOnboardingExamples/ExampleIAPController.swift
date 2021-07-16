//
//  ExampleIAPController.swift
//  HolyOnboardingExamples
//
//  Created by ANDRII ZUIOK on 16.07.2021.
//

import UIKit

class ExampleIAPController: UIViewController {
    
    var goPrevious: (()->())?
    var finished: (()->())?
    
    lazy var leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LEFT", for: .normal)
        button.addTarget(self, action: #selector(goPreviousTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("FINISH", for: .normal)
        button.addTarget(self, action: #selector(finishTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        
        view.addSubview(leftButton)
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            leftButton.heightAnchor.constraint(equalToConstant: 70),
            leftButton.widthAnchor.constraint(equalToConstant: 70),
            leftButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
        
        view.addSubview(finishButton)
        NSLayoutConstraint.activate([
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            finishButton.heightAnchor.constraint(equalToConstant: 70),
            finishButton.widthAnchor.constraint(equalToConstant: 70),
            finishButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
        
    }
    
    @objc func finishTapped(_ sender: UIControl) {
        finished?()
    }
    
    @objc func goPreviousTapped(_ sender: UIControl) {
        goPrevious?()
    }
    
}

