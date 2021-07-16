//
//  HolyOnboardingCustomStackProtocol.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 15.07.2021.
//

import UIKit

public protocol HolyOnboardingCustomStackProtocol: HolyOnboardingNavigationStackProtocol {
    var controllers: [UIViewController] {get set}
    func makeControllers()
    var selectedViewController: UIViewController? {get set}
}
