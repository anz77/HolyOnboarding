//
//  ExampleOnbaordingScreens.swift
//  HolyOnboardingExamples
//
//  Created by ANDRII ZUIOK on 14.07.2021.
//

import Foundation
import HolyOnboarding

enum ExampleOnboardingScreens: String, HolyRawRepresentableControllerMaker {
    case one
    case two
    case three
    
    func getController(coordinator: HolyOnboardingContainerProtocol?) -> HolyOnboardingItem {
        switch self {
        case .one:
            let controller = FirstExampleOnboardigScreen()
            controller.coordinator = coordinator
            return  controller
        case .two:
            let controller = SecondExampleOnboardigScreen()
            controller.coordinator = coordinator
            return  controller
        case .three:
            let controller = ThirdExampleOnboardigScreen()
            controller.coordinator = coordinator
            return  controller
        }
    }
    
    static var defaultFlow: [ExampleOnboardingScreens] = [one, two, three]
}
