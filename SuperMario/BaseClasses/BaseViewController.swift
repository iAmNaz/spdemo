//
//  BaseViewController.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit

/// Abstract base view controller class
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the color to initialize the view
        self.view.backgroundColor = .white
    }
}
