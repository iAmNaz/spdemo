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
    
    /// The root url that starts from the url scheme up to the top-level domain.
    /// For example:
    ///
    /// https://abc.com
    let base: URL
    
    /// The path the include the resouce
    let path: String
    
    /// The query items of a given request
    /// Set your value pairs using an array of `URLQueryItem`
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

/// Build the url and let component do some of the proper url work
/// such as adding percent symbols for white-spaces
/// Using the `Endpoint` type helps ensure we have a valid url
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
