//
//  RootViewModel.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit
import Combine

class RootViewModel: ViewModel {
    
    weak var _screen: UIViewController?
    
    var selectedItemSubject: PassthroughSubject<Selection, Never>?
    
    var store = Set<AnyCancellable>()
    
    var screen: UIViewController? {
        return _screen
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, RowModel>!
    
    func dataSource(tableView: UITableView) -> UITableViewDiffableDataSource<Section, RowModel> {
        dataSource = UITableViewDiffableDataSource<Section, RowModel>(tableView: tableView, cellProvider: { (tableView, indexpath, item) -> UITableViewCell? in
                   let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier, for: indexpath)
                   cell.model = item

                   return cell
               })
        dataSource.defaultRowAnimation = .none
        return dataSource
    }
    
    func setScreen(screen: UIViewController) {
        self._screen = screen
    }
    
    init(){}
    
    func loadRemote() {
        self.screen?.showProgressIndicator()
        
        var request = GameListingRequests()
        
        request.fetchGames()
            .map {
                return $0.map {
                    return RowModel(name: $0.name, series: $0.gameSeries, image: $0.image, cellId: CharacterTableViewCell.self)
                }
        }.sink(receiveCompletion: { [weak self] completion in
            
            self?.hideIndicator()
            
            if case .failure(let error) = completion {
                self?.screen?.showAlert(title: "Error", message: error.localizedDescription, completionHandler: nil)
            }
        }) { [weak self] models in
            
            self?.hideIndicator()
        
            guard var snapshot = self?.dataSource.snapshot() else {
                return
            }
            
            snapshot.appendItems(models, toSection: .primary)
                
            self?.dataSource.apply(snapshot, animatingDifferences: false)
        }
        .store(in: &store)
    }
    
    func hideIndicator() {
        self.screen?.hideProgressIndicator(title: "Characer List")
    }
}
