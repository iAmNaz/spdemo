//
//  UIKit+Protocols.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation

protocol ReuseIdentifier {
    var cellIdentifier: String { get }
}

protocol Cell {
    var rowModel: RowModel! { get set }
    var characterPreViewAction: ((RowModel) -> Void)? { get set }
    var webSearchAction: ((RowModel) -> Void)? { get set }
}
