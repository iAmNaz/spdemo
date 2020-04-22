//
//  ImageViewViewController.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit
import Kingfisher

class FullImageViewViewController: BaseViewController {
    
    fileprivate var imageView = UIImageView(frame: .zero)
    var imageUrl: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Full Image"
        
        view.backgroundColor = UIColor(named: "Yellow")
        imageView.contentMode = .scaleAspectFit
        
        addView(childView: imageView, constraint: ConstraintValues(top: 20, left: 20, right: -20, bottom: -20))
    
        loadImage()
    }
    
    func loadImage() {
        imageView.loadImage(from: imageUrl)
    }

    func setupImageView() {
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        [constraints]
        .forEach(NSLayoutConstraint.activate(_:))
    }
}
