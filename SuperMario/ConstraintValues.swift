//
//  ConstraintValues.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit

struct ConstraintValues {
    var top: CGFloat
    var left: CGFloat
    var right: CGFloat
    var bottom: CGFloat?
    var height: CGFloat?
    var width: CGFloat?
    
    init() {
        self.top = 0
        self.left = 0
        self.right = 0
        self.bottom = 0
    }
    
    init(top: CGFloat, left: CGFloat, right: CGFloat) {
        self.top = top
        self.left = left
        self.right = right
    }
    
    init(top: CGFloat, left: CGFloat, right: CGFloat, bottom: CGFloat) {
        self.top = top
        self.left = left
        self.right = right
        self.bottom = bottom
    }
}
