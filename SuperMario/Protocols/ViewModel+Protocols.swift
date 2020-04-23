//
//  Protocol+ViewModel.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit
import Combine
import Alamofire

protocol ViewModel {
    
    /// The diffable data source of a tableview configured by the view model
    /// - Parameter tableView: Pass a reference of the table view
    func dataSource(tableView: UITableView) -> UITableViewDiffableDataSource<Section, RowModel>
    
    /// Method to pass and set a reference to the current view controller
    /// Parameter screen: A reference to a view controller
    func setScreen<T>(screen: T)
}
