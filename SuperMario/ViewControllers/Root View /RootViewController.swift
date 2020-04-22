//
//  ViewController.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit

enum SubSceneDestination {
    enum SubScene {
        case characterPreview(String)
        case webSearch(String)
    }
    case none
    case render(SubScene)
}

class RootViewController: BaseTableViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Section, RowModel>
    
    let viewModel = RootViewModel()
    
    var state: SubSceneDestination = .none
    
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
    
    func push(to newState: SubSceneDestination) {
        self.state = newState
        
        if case .render(.characterPreview(let imageUrl)) = self.state {
            let url = URL(string: imageUrl)
            let vc = FullImageViewViewController()
            vc.imageUrl = url
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if case .render(.webSearch(let key)) = self.state {
            let vc = SeriesDecriptionViewController()
            vc.searchKey = key
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func dismiss() {
        
    }
}


