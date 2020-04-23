//
//  MockDetailNavigation.swift
//  SuperMarioTests
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
import SuperMario
import UIKit

class MockVC: UIViewController {}

class MockDetailNavigation: NavigableDetail {
    func imageViewer(imageUrl: String) -> UIViewController {
        willNavigateToImagePreview = true
        return MockVC()
    }
    
    func webViewer(key: String) -> UIViewController {
        willNavigateToWebPreview = true
        return MockVC()
    }
    
    var willNavigateToImagePreview: Bool = false
    var willNavigateToWebPreview: Bool = false
    
}
