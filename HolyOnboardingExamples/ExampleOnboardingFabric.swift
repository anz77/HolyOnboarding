//
//  ExampleOnboardingFabric.swift
//  HolyOnboardingExamples
//
//  Created by ANDRII ZUIOK on 17.07.2021.
//

import UIKit
import HolyOnboarding

struct ExampleOnboardingFabric: HolyOnboardingFabric {
    
    func makeControllerFromModel(_ model: ExampleOnboardingScreen, coordinator: HolyOnboardingContainerProtocol?) -> HolyOnboardingItem {
        let controller = FirstExampleOnboardigScreen(color: model.color, titleString: model.title)
        controller.coordinator = coordinator
        return controller
    }
}

