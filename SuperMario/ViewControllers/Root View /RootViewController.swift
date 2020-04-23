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
    case noConnection(String)
    case render(SubScene)
}

class RootViewController: BaseViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Section, RowModel>
    
    let viewModel = RootViewModel()
    
    var state: SubSceneDestination = .none
    
    var dataSource: DataSource! = nil
    
    var tableView = UITableView(frame: .zero)
    
    var statusLabel = UILabel(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addStatusLabel()
        addTableView()
        assignScreen()
        reload()
    }
    
    /// We use the status label to display status messages for network errors
    func addStatusLabel() {
        addView(childView: statusLabel, constraint: ConstraintValues.centered(leftMargin: 30, rightMargin: -30))
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.textColor = .lightGray
        statusLabel.font = UIFont.systemFont(ofSize: 16)
        statusLabel.isHidden = true
    }
    
    /// Setup the tableview
    func addTableView() {
        addView(childView: tableView, constraint: .init())
        tableView.register(cellType: CharacterTableViewCell.self)
        
        configureTableView()
        dataSource = self.viewModel.dataSource(tableView: self.tableView)
    }
    
    /// Assign this controller to the view model
    func assignScreen() {
        viewModel.setScreen(screen: self)
    }
    
    /// Configure the table view with automatic dimensions
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 85
        tableView.tableFooterView = UIView()
    }
    
    /// This is called to load or reload data from the server
    @objc func reload() {
        if let gesture = tapGesture {
            view.removeGestureRecognizer(gesture)
        }
        self.statusLabel.text = ""
        self.statusLabel.isHidden = true
        self.tableView.isHidden = false
        viewModel.loadRemoteData()
    }
    
    var tapGesture: UITapGestureRecognizer?
    
    /// A method to display the network error / status
    func updateStatus(_ message: String) {
        self.tableView.isHidden = true
        self.statusLabel.isHidden = false
        self.statusLabel.text = message + "\nTap to retry."
        
        if  tapGesture == nil {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.reload))
            tapGesture!.numberOfTapsRequired = 1
        }
        
        view.addGestureRecognizer(tapGesture!)
    }
}

extension RootViewController: Transitionable {
    
    func display(to newState: SubSceneDestination) {
        
        self.state = newState
        
        if case .noConnection(let message) = self.state {
            self.updateStatus(message)
        }
    }
    
    func push(to newState: SubSceneDestination) {
        
        self.state = newState
        
        if case .render(.characterPreview(let imageUrl)) = self.state {
            let url = URL(string: imageUrl)
            let controller = FullImageViewViewController()
            controller.imageUrl = url
            
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        if case .render(.webSearch(let key)) = self.state {
            let controller = SeriesDecriptionViewController()
            controller.searchKey = key
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
