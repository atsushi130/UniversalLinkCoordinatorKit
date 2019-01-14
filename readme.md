<p align="center">
    <h1 align="center">UniversalLinkCoordinatorKit</h1>
</p1>

<p align="center"><i>UniversalLinkCoordinator is handling universal link interface.</i></p>

<p align="center">
    <a href=".license"><img src="https://img.shields.io/badge/license-MIT-blue.svg"></a> 
    <a href="https://github.com/atsushi130/UniversalLinkCoordinatorKit.git"><img src="https://img.shields.io/badge/Swift-UniversalLinkCoordinatorKit-3B5998.svg"></a> 
    <img src="https://img.shields.io/badge/Swift-4-ffac45.svg">
</p>

## Installation
**Install via [Carthage](https://github.com/Carthage/Carthage)**  
```
github "atsushi130/UniversalLinkCoordinatorKit"
```

## Usage
Conform to UniversalLinkCoordinator:
```swift
final class MyUniversalLinkCoordinator: UniversalLinkCoordinator {

    static let scheme = "org-app"
    var viewController: UIViewController?

    enum Route {
        case settings(settingId: Int)
        case home
    }

    func transitionIfNeeded(from universalLink: String) {
        guard let route = Route.handle(scheme: Self.scheme, universalLink: universalLink) else { return }
        self.transition(to: route)
    }

    func transition(to route: Route) {
        switch route {
        case .settings(let settingId):
            let settingViewController = SettingViewController.viewController() // ref: CoordinatorKit
            self.viewController.present(settingViewController, animated: true)
        case .home
            let homeViewController = HomeViewController.viewController()
            self.viewController.present(homeViewController, animated: true)
        }
    }
}

extension MyUniversalLinkCoordinator.Route {
    static func handle(scheme: String, universalLink: String) -> Route? {
        guard let parsedUniversalLink = UniversalLink.parse(scheme: scheme, universalLink: universalLink) else { return nil }
        switch parsedUniversalLink.uri {
        case "/settings":
            guard let settingId = universalLink.queryString["setting_id", Int.self] else { return nil }
            return .settings(settingId: settingId)
        case "/home":
            return .home
        }
    }
}
```

## License
UniversalLinkCoordinatorKit is available under the MIT license. See the [LICENSE file](https://github.com/atsushi130/UniversalLinkCoordinatorKit/blob/master/license).
