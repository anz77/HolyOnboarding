//
//  HolyBaseOnboardingControllerProtocol.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 13.07.2021.
//

import UIKit

protocol HolyBaseOnboardingController: UIViewController, HolyOnboardingNavigationProtocol {}

protocol HolyOnboardingNavigationProtocol {
    var coordinator: HolyCoordinatorProtocol? {get set}
    func goPrevious() -> Void
    func goNext() -> Void
}

