//
//  EndPoint.swift
//  SuperMario
//
//  Created by Nazario Mariano on 3/23/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit

/**
 The endpoint helps in building a complete url for a request
 */
struct Endpoint {
    let base: URL
    let path: String
    var queryItems: [URLQueryItem]
}

// We will declare out enpoints here
extension Endpoint {
    static var root: Endpoint {
        return Endpoint(
            base: BASEURL!,
            path: "/api/amiibo",
            queryItems: []
        )
    }
}

// Build our url and let component do some of the proper url work
extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = base.scheme
        components.host = base.host
        components.port = base.port
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}
