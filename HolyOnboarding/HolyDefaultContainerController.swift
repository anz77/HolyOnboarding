//
//  HolyDefaultContainerController.swift
//  HolyOnboarding
//
//  Created by ANDRII ZUIOK on 13.07.2021.
//

import UIKit


enum SomeEnum: Int, HolyRawRepresentableControllerMaker {
    static var defaultFlow: [SomeEnum] = [.one, two]
    
    case one
    case two
    
    func getController() -> HolyBaseOnboardingController {
        switch self {
        case .one:
            return FirstTypeController()
        default:
            return SecondTypeController()
        }
    }
}

class FirstTypeController: UIViewController, HolyBaseOnboardingController {
    var coordinator: HolyCoordinatorProtocol?
    func goPrevious() {}
    func goNext() {}
}

class SecondTypeController: UIViewController, HolyBaseOnboardingController {
    var coordinator: HolyCoordinatorProtocol?
    func goPrevious() {}
    func goNext() {}
}


//class ContainerController<T: HolyRawRepresentableControllerMaker>: UIViewController {
//    var onboardingFlow: [T] = []
//    var controllers: [HolyBaseOnboardingController] = []
//    func makeControllers() {
//        controllers = onboardingFlow.compactMap({ $0.getController() })
//    }
//}


class HolyDefaultContainerController<T: HolyRawRepresentableControllerMaker>: UIViewController, HolyContainerControllerProtocol {
    
    var associatedOptions: [String: Any] = [:]
    
    var onboardingFlow: [T] = []
    var controllers: [HolyBaseOnboardingController] = []
    
    init(onboardingFlow: [T] = []) {
        self.onboardingFlow = onboardingFlow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

func makeContainer() {
    let obj = HolyDefaultContainerController<SomeEnum>()
    obj.onboardingFlow = [.one]
    obj.makeControllers()
}
