//
//  ExampleRemoteSource.swift
//  HolyOnboardingExamples
//
//  Created by ANDRII ZUIOK on 17.07.2021.
//

import Foundation
import HolyOnboarding

class ExampleRemoteSource: HolyRemoteSource {
    func getModelsFromRemoteConfig(key: String, completion: @escaping ([ExampleOnboardingScreen]) -> ()) {
        let exampleModels: [ExampleOnboardingScreen] = [.init(color: .orange, title: "orange"), .init(color: .green, title: "green"), .init(color: .yellow, title: "yellow"), .init(color: .blue, title: "blue")]
        completion(exampleModels)
    }
    
    
}
