//
//  Body.swift
//  SuperMario
//
//  Created by Nazario Mariano on 3/23/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
/**
 The type for the request body parameters
 */
public struct Body {

    /// Here you will define static / predefined parameters for a given resource or request
    enum Route {
        
        case getSeries
        
        func preset() -> [String: Any] {
            switch self {
            case .getSeries:
                return [:]
            }
        }
    }
    
    private(set) var data: [String: Any] = [:]
    
    /// Using this initializer you can select a predefined body parameter and
    /// append additional arbitrary parameters to your requests
    /// - Parameter route: An enum of predefined parameters
    /// - Parameter extras: For parameters that are generated dynamically depending on the use case.
    init(route: Route, extras: [String: Any]? = nil) {
        self.data.merge(route.preset()) { (current, _) in current }
        guard let copy = extras else {
            return
        }
        data.merge(copy) { (current, _) in current }
    }
}
