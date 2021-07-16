//
//  HolyBaseOnboardingControllerProtocol.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 13.07.2021.
//

import UIKit

public protocol HolyOnboardingItem: UIViewController {
    var coordinator: HolyOnboardingContainerProtocol? {get set}
    var isInitial: Bool {get set}
    var isFinal: Bool {get set}
}
