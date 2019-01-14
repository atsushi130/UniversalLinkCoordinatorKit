//
//  UniversalLink.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/14.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

public struct UniversalLink {
    
    public let scheme: String
    public let uri: String
    public let queryString: QueryString?
    
    public static func parse(scheme: String, universalLink: String) -> UniversalLink? {
        
        let universalLinks = universalLink
            .replacingOccurrences(of: scheme + ":/", with: "")
            .split(separator: "?")
            .map(String.init)
        
        guard !universalLinks.isEmpty,
            let uri = universalLinks.first else { return nil }
        
        guard universalLinks.count == 2,
            let components = URLComponents(string: universalLink),
            let queryItems = components.queryItems else {
                return UniversalLink(scheme: scheme, uri: uri, queryString: nil)
        }
        
        return UniversalLink(scheme: scheme, uri: uri, queryString: QueryString(from: queryItems))
    }
}

public extension UniversalLink {
    
    public struct QueryString {
        
        private let queryString: [String: String]
        
        init(from queryItems: [URLQueryItem]) {
            self.queryString = queryItems
                .reduce([:]) { items, item in
                    if let value = item.value {
                        var items = items
                        items[item.name] = value
                        return items
                    } else {
                        return items
                    }
                }
        }
        
        subscript<T: Extractable>(key: String, type: T.Type) -> T? {
            guard let value = self.queryString[key] else { return nil }
            return type.extract(from: value)
        }
        
        subscript(key: String) -> String? {
            return self.queryString[key]
        }
    }
}
