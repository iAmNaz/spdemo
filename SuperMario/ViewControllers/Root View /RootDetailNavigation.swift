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
    /// Refers to the view controller displaying the full image of the series
    func imageViewer(imageUrl: String) -> UIViewController
    
    /// This refers to the view controller with a webview
    func webViewer(key: String) -> UIViewController
}

/// The implementation of the `NavigableDetail`
/// The concrete destination scenes or views are defined here
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
