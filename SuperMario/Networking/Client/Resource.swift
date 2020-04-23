//
//  Resource.swift
//  SuperMario
//
//  Created by Nazario Mariano on 3/23/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
import Alamofire
/**
    Encapsulates the url of the resource and http method
 */
public struct Resource {
    /// The complete url of the resource
    public let url: URL
    
    /// The HTTP method for a given request and set with a default GET method
    public let method: HTTPMethod = .get
}
