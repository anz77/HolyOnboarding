//
//  HolyOnboardingFabric.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 16.07.2021.
//

import Foundation

public protocol HolyOnboardingFabric {
    associatedtype Model: HolyOnboardingModel
    func makeControllerFromModel(_ model: Model, coordinator: HolyOnboardingContainerProtocol?) -> HolyOnboardingItem
}
