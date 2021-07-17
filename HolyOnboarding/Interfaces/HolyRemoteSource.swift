//
//  HolyRemoteSource.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 17.07.2021.
//

import Foundation

public protocol HolyRemoteSource: AnyObject {
    associatedtype Model: HolyOnboardingModel
    func getModelsFromRemoteConfig(key: String, _ completion: @escaping ([Model])->())
}
