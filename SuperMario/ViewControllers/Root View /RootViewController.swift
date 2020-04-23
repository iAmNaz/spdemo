//
//  ViewController.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit

/// On this controller the game series are displayed as rows of images and
/// series information.
class RootViewController: BaseViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Section, RowModel>
    
    var viewModel = RootViewModel()
    
    var state: SubSceneDestination = .none
    
    var dataSource: DataSource! = nil
    
    var tableView = UITableView(frame: .zero)
    
    var statusLabel = UILabel(frame: .zero)
    
    var detailViews: NavigableDetail = RootViewDetailViews()
    
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
    
    /// Gesture applied to the view so the user can interact with it
    /// when needed to reload the remote data
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

/// The implementation of the `Transitionable` protocol
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
            let controller = self.detailViews.imageViewer(imageUrl: imageUrl)
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        if case .render(.webSearch(let key)) = self.state {
            let controller = self.detailViews.webViewer(key: key)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

/// Scene state options
enum SubSceneDestination {
    
    /// Destination views
    enum SubScene {
        /// The full screen image view
        case characterPreview(String)
        
        /// The web search view
        case webSearch(String)
    }
    
    /// Used as a placeholder value
    case none
    
    /// The state for network related errors
    case noConnection(String)
    
    /// The state to transition to another view state
    case render(SubScene)
}

/// Equatable implementation of the `SubSceneDestination` enum
extension SubSceneDestination: Equatable {
    static func == (lhs: SubSceneDestination, rhs: SubSceneDestination) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case (.noConnection, .noConnection):
            return true
        case (.render(.characterPreview), .render(.characterPreview)):
            return true
        case (.render(.webSearch), .render(.webSearch)):
            return true
        default:
            return false
        }
    }
}
