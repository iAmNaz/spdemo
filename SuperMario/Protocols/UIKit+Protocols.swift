//
//  UIKit+Protocols.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation

/// This protocol is implemented by types that are used a data models of tableviewcells
protocol ReuseIdentifier {
    
    /// The reusable identifier of a cell
    /// - Returns: A `String` of the identifier
    var cellIdentifier: String { get }
}

/// UITableViewCell types conform to this protocol
protocol Cell {
    /// The cell's view model
    var rowModel: RowModel! { get set }
    
    /// The code block to call for the full screen image view
    var characterPreViewAction: ((RowModel) -> Void)? { get set }
    
    /// The code block that is executed when the right half or information half of the cell is tapped
    var webSearchAction: ((RowModel) -> Void)? { get set }
}
