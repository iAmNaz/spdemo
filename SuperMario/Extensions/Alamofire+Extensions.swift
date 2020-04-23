//
//  Alamofire+Extensions.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Alamofire

extension Session {
    /// A custom method to pass the request components
    func request(_ resource: Resource, body: Body, method: HTTPMethod = .get) -> DataRequest {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        return self.request(resource.url,
        method: method,
        parameters: body.data,
        headers: headers)
    }
}
