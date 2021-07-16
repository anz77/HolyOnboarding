//
//  HolyRawRepresentableControllerMaker.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 13.07.2021.
//

import UIKit

public protocol HolyRawRepresentableControllerMaker: RawRepresentable {
    func getController(coordinator: HolyOnboardingContainerProtocol?) -> HolyOnboardingItem
    static var defaultFlow: [Self] {get}
}

public extension HolyRawRepresentableControllerMaker {
    static func makeFlowFromSequence(_ sequence: [Self.RawValue]) -> [Self] {
        return sequence.compactMap {Self.init(rawValue: $0)}
    }
}
