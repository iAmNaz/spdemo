//
//  Response.swift
//  SuperMario
//
//  Created by Nazario Mariano on 3/23/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
public protocol Response: Codable {
    associatedtype CodableType
    var result: Int { get set }
    var data: CodableType { get set }
}
