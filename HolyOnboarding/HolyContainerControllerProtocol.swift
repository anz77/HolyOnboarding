//
//  HolyContainerControllerProtocol.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 13.07.2021.
//

import Foundation

protocol HolyCoordinatorProtocol: AnyObject {
    var controllers: [HolyBaseOnboardingController] {get set}
}



protocol HolyContainerControllerProtocol: HolyCoordinatorProtocol {
    associatedtype T: HolyRawRepresentableControllerMaker
    var associatedOptions: [String: Any] {get set}
    var onboardingFlow: [T] {get set}
}

extension HolyContainerControllerProtocol {
    func makeControllers() {
        controllers = onboardingFlow.compactMap({ $0.getController() })
    }
}
