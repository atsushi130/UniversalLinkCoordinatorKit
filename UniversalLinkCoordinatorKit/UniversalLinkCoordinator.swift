//
//  UniversalLinkCoordinator.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/14.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation

public protocol UniversalLinkCoordinator: class {
    associatedtype Route
    associatedtype UniversalLink: UniversalLinkable
    var router: UniversalLinkRouter<UniversalLink> { get }
    @discardableResult
    func transitionIfPossible(open universalLink: URL) -> Bool
    func transition(to route: Route)
}

public extension UniversalLinkCoordinator where Route == (universalLink: UniversalLink, context: UniversalLinkContext) {
    @discardableResult
    public func transitionIfPossible(open universalLink: URL) -> Bool {
        guard let route = self.router.handle(universalLink) else { return false }
        self.transition(to: route)
        return true
    }
}
