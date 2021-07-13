//
//  HolyRawRepresentableControllerMaker.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 13.07.2021.
//

import UIKit

protocol HolyRawRepresentableControllerMaker: RawRepresentable {
    func getController() -> HolyBaseOnboardingController
    static var defaultFlow: [Self] {get}
    //static func makeFlowFromSequence(_ sequence: [Self.RawValue]) -> [Self]
}

extension HolyRawRepresentableControllerMaker {
    static func makeFlowFromSequence(_ sequence: [Self.RawValue]) -> [Self] {
        return sequence.compactMap {Self.init(rawValue: $0)}
    }
}
