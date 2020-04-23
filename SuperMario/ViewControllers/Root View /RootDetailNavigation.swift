//
//  RootDetailNavigation.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit

/// Multiple destinations of a given view controller
public protocol NavigableDetail: class {
    func imageViewer(imageUrl: String) -> UIViewController
    func webViewer(key: String) -> UIViewController
}

class RootViewDetailViews: NavigableDetail {
    func imageViewer(imageUrl: String) -> UIViewController {
        let url = URL(string: imageUrl)
        let controller = FullImageViewViewController()
        controller.imageUrl = url
        return controller
    }
    
    func webViewer(key: String) -> UIViewController {
        let controller = SeriesDecriptionViewController()
        controller.searchKey = key
        return controller
    }
}
