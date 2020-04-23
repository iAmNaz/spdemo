//
//  Foundation+Extensions.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
public enum APIError: Error {
    
    case error(message: String)
    
    var message: String {
        switch self {
            case .error(let message):
                return message
        }
    }
}
