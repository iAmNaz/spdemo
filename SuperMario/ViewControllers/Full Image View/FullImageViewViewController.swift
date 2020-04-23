//
//  ImageViewViewController.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit
import Kingfisher

/// The view controller for the full screen image display
class FullImageViewViewController: BaseViewController {
    
    /// Inbound url of the image
    var imageUrl: URL!
    
    fileprivate var imageView = UIImageView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Full Image"
        
        view.backgroundColor = UIColor(named: "Yellow")
        imageView.contentMode = .scaleAspectFit
        
        addView(childView: imageView, constraint: ConstraintValues(top: 20, left: 20, right: -20, bottom: -20))
    
        loadImage()
    }
    
    fileprivate func loadImage() {
        imageView.loadImage(from: imageUrl)
    }
}
