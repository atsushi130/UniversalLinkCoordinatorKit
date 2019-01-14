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

    /// Universal Links
    /// Scheme: - org-app
    /// route:
    ///     - org-app://threads?thread_id=Int
    ///     - org-app://home
    enum Route {
        case threads(threadId: Int)
        case home
    }

    func transition(to route: Route) {
        switch route {
        case .threads(let threadId):
            let ThreadsViewController = ThreadsViewController.instantiate() // ref: CoordinatorKit
            self.viewController.present(threadsViewController, animated: true) {
                let threadViewController = ThreadViewController.instantiate()
                threadsViewController.present(threadViewController, animated: true)
            }
        case .home
            let homeViewController = HomeViewController.instantiate()
            self.viewController.present(homeViewController, animated: true)
        }
    }
}

extension MyUniversalLinkCoordinator.Route {
    static func handle(scheme: String, universalLink: String) -> Route? {
        guard let parsedUniversalLink = UniversalLink.parse(scheme: scheme, universalLink: universalLink) else { return nil }
        switch parsedUniversalLink.uri {
        case "/threads":
            guard let threadId = universalLink.queryString["thread_id", Int.self] else { return nil }
            return .threads(threadId: threadId)
        case "/home":
            return .home
        }
    }
}
```
reference: [CoordinatorKit](https://github.com/atsushi130/CoordinatorKit)

## License
UniversalLinkCoordinatorKit is available under the MIT license. See the [LICENSE file](https://github.com/atsushi130/UniversalLinkCoordinatorKit/blob/master/license).
