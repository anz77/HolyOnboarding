//
//  HolyContainerControllerProtocol.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 13.07.2021.
//

import UIKit

public protocol HolyOnboardingNavigationStackProtocol: HolyOnboardingContainerProtocol, HolyOnboardingFlowProtocol {}

public protocol HolyOnboardingContainerProtocol: AnyObject, HolyOnboardingNavigationProtocol, HolyOnboardingAnalyticsProtocol {
    var showIDFA: (()->())? {get set}
    var makeIAPController: (()->UIViewController)? {get set}
    var finishOnboarding: (()->())? {get set}
}

public protocol HolyOnboardingFlowProtocol {
    associatedtype T: HolyRawRepresentableControllerMaker
    var environmentValues: [String: Any] {get set}
    var onboardingFlow: [T] {get set}
}

public protocol HolyOnboardingNavigationProtocol {
    func goNext() -> Void
    func goPrevious() -> Void
}

public protocol HolyOnboardingAnalyticsProtocol {
    var analyticsHandler: OnboardingAnalyticsHandler? {get set}
    func sendAnalyticEvent(key: String, values: [String: Any])
    func sendAnalyticEvent(key: String, value: Any)
}

public protocol OnboardingAnalyticsHandler: AnyObject {
    func sendAnalyticEvent(key: String, values: [String: Any])
    func sendAnalyticEvent(key: String, value: Any)
}
