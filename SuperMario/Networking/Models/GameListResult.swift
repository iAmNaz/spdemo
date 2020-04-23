//
//  GameListResult.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation

/**
 This codable type represent the json response from the 'amiibo' end point
 */
struct GameListResult: Codable {
    
    /// An array of game series
    var series: [Series]
    
    enum CodingKeys: String, CodingKey {
        case series = "amiibo"
    }
}
