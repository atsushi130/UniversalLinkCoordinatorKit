//
//  UniversalLinkRouter.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/21.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation

public final class UniversalLinkRouter<UniversalLink> where UniversalLink: UniversalLinkable {

    private var routes: [UniversalLink] = []
    
    public func register(routes: [UniversalLink]) {
        routes.forEach { self.routes.append($0) }
    }
    
    public func handle(_ universalLink: URL) -> (UniversalLink, UniversalLinkContext)? {
        return self.routes
            .lazy
            .flatMap { route in
                if let context = route.parse(universalLink) {
                    return (route, context)
                } else {
                    return nil
                }
            }
            .first
    }
}
