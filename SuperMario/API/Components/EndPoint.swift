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
    let path: String
    var queryItems: [URLQueryItem]
}

// We will declare out enpoints here
extension Endpoint {
    static var root: Endpoint {
        return Endpoint(
            path: "/api/amiibo",
            queryItems: []
        )
    }
}

// Build our url and let component do some of the proper url work
extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = BASEURL!.scheme
        components.host = BASEURL!.host
        components.port = BASEURL!.port
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}
