//
//  Series.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation

/**
 The data model representing the series document
 */
public struct Series: Codable {
    /// Character name
    var name: String
    
    /// Game series
    var gameSeries: String
    
    /// Character image
    var image: String
    
    /// Provided initializer for convenience
    public init(name: String, gameSeries: String, image: String) {
        self.name = name
        self.gameSeries = gameSeries
        self.image = image
    }
    
    enum CodingKeys: String, CodingKey {
        case name, gameSeries, image
    }
}
