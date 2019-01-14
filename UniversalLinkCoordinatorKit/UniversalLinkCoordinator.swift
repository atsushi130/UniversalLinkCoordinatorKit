//
//  UniversalLinkCoordinator.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/14.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation
import CoordinatorKit

public protocol UniversalLinkCoordinator: Coordinator where Route: UniversalLinkHandlable {
    static var scheme: String { get }
    func transitionIfNeeded(from universalLink: String)
}

public extension UniversalLinkCoordinator {
    public func transitionIfNeeded(from universalLink: String) {
        guard let route = Self.Route.handle(scheme: Self.scheme, universalLink: universalLink) else { return }
        self.transition(to: route)
    }
}

public protocol UniversalLinkHandlable {
    static func handle(scheme: String, universalLink: String) -> Self?
}
