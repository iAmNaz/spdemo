//
//  Series.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation

struct Series: Codable {
    var name: String
    var gameSeries: String
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case name, gameSeries, image
    }
}
