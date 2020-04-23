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

enum ActionType {
    case character
    case search
}

struct Selection {
    var actionType: ActionType
    var indexPath: IndexPath
}

protocol ViewModel {
    var selectedItemSubject: PassthroughSubject<Selection, Never>? { get set }
    func dataSource(tableView: UITableView) -> UITableViewDiffableDataSource<Section, RowModel>
    func setScreen<T>(screen: T)
}
