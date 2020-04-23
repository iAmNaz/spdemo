//
//  RowModel.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
struct RowModel: ReuseIdentifier {
    
    /// The cell identifier for the `UITableViewCell`
    var cellIdentifier: String
    
    /// The id as required by the `UITableViewDiffableDataSource`
    var identifier = UUID().uuidString
    
    /// Name of the series character
    var name: String
    
    /// Series name
    var series: String
    
    /// Associated image of the series
    var image: String
    
    /// Common initializer for this struct
    /// - Parameter name: The name of the character
    /// - Parameter series: The series name
    /// - Parameter image: Series image
    /// - Parameter cellId: Type of the `UITableViewCell`
    init<T>(name: String, series: String, image: String, cellId: T.Type = T.self) {
        self.cellIdentifier = String(describing: cellId)
        self.name = name
        self.series = series
        self.image = image
    }
}

/// Hashable implementation
extension RowModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: RowModel, rhs: RowModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
