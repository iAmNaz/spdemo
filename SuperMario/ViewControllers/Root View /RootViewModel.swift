//
//  RootViewModel.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit
import Combine

// Section id for the table secionts
enum Section: CaseIterable {
    case primary
    case secondary
}

class RootViewModel: ViewModel {
    
    fileprivate weak var _screen: RootViewController?

    fileprivate var store = Set<AnyCancellable>()
    
    fileprivate var screen: RootViewController? {
        return _screen
    }
    
    fileprivate var dataSource: UITableViewDiffableDataSource<Section, RowModel>!
    
    func dataSource(tableView: UITableView) -> UITableViewDiffableDataSource<Section, RowModel> {
        dataSource = UITableViewDiffableDataSource<Section, RowModel>(tableView: tableView, cellProvider: { [weak self] (tableView, indexpath, item) -> UITableViewCell? in
                   let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier, for: indexpath)
            
                   cell.model = item
            
                    cell.previewAction = { model in
                        self?.screen?.push(to: .render(.characterPreview(model.image)))
                    }
                    
                    cell.searchAction = { model in
                        self?.screen?.push(to: .render(.webSearch(item.series)))
                    }
            
                   return cell
               })
        
        dataSource.defaultRowAnimation = .none
        return dataSource
    }
    
    func setScreen<T>(screen: T) {
        self._screen = (screen as! RootViewController)
    }
     
    init() {}
    
    func loadRemoteData() {
        
        self.screen?.showProgressIndicator()
        
        var request = GameListingRequests()
        
        request.fetchSeries()
            .map {
                return $0.map {
                    return RowModel(name: $0.name, series: $0.gameSeries, image: $0.image, cellId: CharacterTableViewCell.self)
                }
        }.sink(receiveCompletion: { [weak self] completion in
            
            self?.hideIndicator()
            
            if case .failure(let error) = completion {
                
                self?.screen?.display(to: .noConnection(error.errorDescription!))
                
                self?.screen?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }, receiveValue: { [weak self] models in
            
            self?.hideIndicator()
            self?.applyData(models: models)
        })
        .store(in: &store)
    }
    
    func applyData(models: [RowModel]) {
        
        var snapshot = self.dataSource.snapshot()
    
        snapshot.appendSections([.primary])
        snapshot.appendItems(models, toSection: .primary)
            
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func hideIndicator() {
        self.screen?.hideProgressIndicator(title: "Characer List")
    }
}
