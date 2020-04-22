//
//  ViewController.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit

enum RootViewState {
    case limitedConnection
    case loading
    case render
}

class RootViewController: BaseViewController {
    
    typealias StateType = RootViewState
    typealias DataSource = UITableViewDiffableDataSource<Section, RowModel>
    
    let viewModel = RootViewModel()
    
    var state: StateType = .loading
    
    var dataSource: DataSource! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: CharacterTableViewCell.self)
        configureTableView()
        dataSource = self.viewModel.dataSource(tableView: self.tableView)
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.primary])
        dataSource.apply(snapshot)
        viewModel.setScreen(screen: self)
        viewModel.loadRemote()
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 85
        tableView.tableFooterView = UIView()
    }
}

extension RootViewController: Transitionable {
    
    func push(to newState: RootViewState) {
        
    }
    
    func display(to newState: RootViewState) {
        
    }
    
    func dismiss() {
        
    }
}


