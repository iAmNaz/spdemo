//
//  RowModel.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
struct RowModel: ReuseIdentifier {
    var cellIdentifier: String
    var identifier = UUID().uuidString
    var name: String
    var series: String
    var image: String
    
    init<T>(name: String, series: String, image: String, cellId: T.Type = T.self) {
        self.cellIdentifier = String(describing: cellId)
        self.name = name
        self.series = series
        self.image = image
    }
}

extension RowModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: RowModel, rhs: RowModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
