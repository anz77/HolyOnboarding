Simple llibrary for presenting onboarding flow in iOS application. Working with any model of content and is customizable to your needs.

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.0-orange.svg" />
  <img src="https://img.shields.io/badge/platform-iOS-lightgray.svg" />
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" />
  <img src="https://img.shields.io/badge/Cocoapods-✔-green.svg" />
</p>


## Examples
```Swift
// Show onboarding...

func showNawOnboarding() {
        
        // create remote config (for example Firebase Remote Config) manager / sourse...
        let source = ExampleRemoteSource()
        
        // get array of models from source...
        source.getModelsFromRemoteConfig(key: "") { [weak self] (models: [ExampleOnboardingScreen]) in
            
            // create container for onboarding flow..
            let container = HolyDefaultNavigationStackController<ExampleOnboardingScreen, ExampleOnboardingFabric>(onboardingFlow: models, fabric: ExampleOnboardingFabric())
            
            // add page control for container (if it is needed)...
            let pageControl = UIPageControl()
            container.pageControl = pageControl
            
            // add custom IAP controller for finish point in onboarding flow (if it needed)...
            container.makeIAPController = { [weak container] in
                let iapController = ExampleIAPController()
                iapController.finished = { [weak container] in
                    container?.finishOnboarding?()
                }
                iapController.goPrevious = { [weak container] in
                    container?.goPrevious()
                }
                return iapController
            }
            
            // handle IDFA showing (if it is needed)...
            container.showIDFA = {}

            // handle onboarding finish
            container.finishOnboarding = { [weak container] in
                container?.dismiss(animated: true, completion: {})
            }
             
            // present onboarding container...           
            container.modalPresentationStyle = .automatic
            container.modalTransitionStyle = .coverVertical
            self?.present(container, animated: true) {}
        }
}
```

- View the _HolyOnboardingExamples_ app for more.

## Usage
### Create your model struct / class / enum etc...
```Swift
struct ExampleOnboardingScreen: HolyOnboardingModel {
    var color: UIColor
    var title: String
}
```

### Create fabric / builder for creating screens from models...
```Swift
struct ExampleOnboardingFabric: HolyOnboardingFabric {
    
    func makeControllerFromModel(_ model: ExampleOnboardingScreen, coordinator: HolyOnboardingContainerProtocol?) -> HolyOnboardingItem {
        let controller = FirstExampleOnboardigScreen(color: model.color, titleString: model.title)
        controller.coordinator = coordinator
        return controller
    }
}
```

### Confirm remote config service to HolyRemoteSource protocol...
```Swift
extension RemoteConfigService: HolyRemoteSource {
  func getModelsFromRemoteConfig(key: String, completion: @escaping ([ExampleOnboardingScreen]) -> ()) {
        // default
        let exampleModels: [ExampleOnboardingScreen] = [.init(color: .orange, title: "orange"), .init(color: .green, title: "green"), .init(color: .yellow, title: "yellow"), .init(color: .blue, title: "blue")]
        completion(exampleModels)
        // or
        ...URLSession.shared.dataTask... and completion(exampleModels)
    }
  }
```

### Create your screens and confirm them to HolyOnboardingItem protocol...
```Swift
class FirstExampleOnboardigScreen: UIViewController, HolyOnboardingItem {

    weak var coordinator: HolyOnboardingContainerProtocol?
    var isInitial: Bool = false
    var isFinal: Bool = false
    
    // custom values...
    var color: UIColor
    var titleString: String
    
```

## Installation
### Cocoapods
```bash
pod 'HolyOnboarding'
```
### Manually
Add all files from the `HolyOnboarding` folder to your project.


## License
HolyOnbaording is available under the MIT license. See the LICENSE file for more info.

