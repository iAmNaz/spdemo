//
//  Foundation+Extensions.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
public enum APIError: Error {
    case noData
    case undefinedContentType
    case parsingError
    case error(message: String)
    
    var localizedDescription: String {
        switch self {
        case .noData:
            return "Data not received on empty"
        case .undefinedContentType:
            return "Content type undefined"
        case .parsingError:
            return "Error reading data"
        case .error(let message):
            return message
        }
    }
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData:
            return NSLocalizedString("The server responded with no data", comment: "no data")
        case .undefinedContentType:
            return NSLocalizedString("The content type is undefined", comment: "undefined type")
        case .parsingError:
            return NSLocalizedString("Error in reading the response", comment: "parsing error")
        case .error(message: let message):
            return message
        }
    }
}
