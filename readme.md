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

    let router = UniversalLinkRouter<UniversalLink>()

    typealias Route = (universalLink: UniversalLink, context: UniversalLinkContext)
    enum UniversalLink: String, UniversalLinkable {
        static var scheme: String { return "my-app" }
        case threads = "/threads/:thread_id"
    }
    
    func transition(to route: Route) {
        switch route.universalLink {
        case .threads:
            guard let threadId: Int = route.context.parameters["thread_id"] else { return }
            print("threadId: \(threadId)")
        }
    }
}
```

**AppDelegate.swift**
```swift
let coordinator = MyUniversalLinkCoordinator()
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    return self.coordinator.transitionIfPossible(open: url, with: .options(options))
}

func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    guard let urlString = userInfo["url"] as? String,
          let url = URL(string: urlString) else { return }
    switch application.applicationState {
	case .active: break
    case .background, .inactive:
        self.coordinator.transitionIfPossible(open: url, with: .userInfp(userInfo))
    }
}
```

## License
UniversalLinkCoordinatorKit is available under the MIT license. See the [LICENSE file](https://github.com/atsushi130/UniversalLinkCoordinatorKit/blob/master/license).
