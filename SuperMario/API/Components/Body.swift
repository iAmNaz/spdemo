//
//  Body.swift
//  SuperMario
//
//  Created by Nazario Mariano on 3/23/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import Foundation
/**
 Body parameters
 */
public struct Body {

    enum Route {
        case getGames
        
        func preset() -> [String: Any] {
            switch self {
            case .getGames:
                return [:]
            }
        }
    }
    
    private(set) var data: [String: Any] = [:]
    
    init(route: Route, extras: [String: Any]? = nil) {
        self.data.merge(route.preset())  { (current, _) in current }
        guard let copy = extras else {
            return
        }
        data.merge(copy)  { (current, _) in current }
    }
}
