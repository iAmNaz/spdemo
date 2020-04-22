//
//  GameListResult.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
struct GameListResult: Codable {
    var series: [Series]
    
    enum CodingKeys: String, CodingKey {
        case series = "amiibo"
    }
}
