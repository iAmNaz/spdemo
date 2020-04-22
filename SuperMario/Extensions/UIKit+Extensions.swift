//
//  UIKit+Extensions.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    var model: RowModel {
        get {
            return (self as! Cell).rowModel
        }
        set {
            var row = (self as! Cell)
            row.rowModel = newValue
        }
    }
    
    var previewAction: ((RowModel) -> Void)? {
        get {
            return (self as! Cell).characterPreViewAction
        }
        set {
            var row = (self as! Cell)
            row.characterPreViewAction = newValue
        }
    }
    
    var searchAction: ((RowModel) -> Void)? {
        get {
            return (self as! Cell).webSearchAction
        }
        set {
            var row = (self as! Cell)
            row.webSearchAction = newValue
        }
    }
}

protocol Transitionable:class {
    associatedtype Destination
    func push(to newState: Destination)
    func showAlert(title: String, message: String, completionHandler: ((String?)->Void)?)
    func dismiss()
}

extension UIViewController {    
    func showAlert(title: String, message: String, completionHandler: ((String?)->Void)?) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let submitAction = UIAlertAction(title: "OK", style: .default) { _ in
                completionHandler?(nil)
                ac.dismiss(animated: true, completion: nil)
            }
            ac.addAction(submitAction)
        
        if let vc = self.navigationController?.visibleViewController {
            vc.present(ac, animated: true)
        }
    }
    
    func showProgressIndicator() {
        self.title = "Loading..."
    }
    
    func hideProgressIndicator(title: String) {
        self.title = title
    }
    
    func addView(childView: UIView, constraint: ConstraintValues) {
        
        view.addSubview(childView)
    
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [
            childView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constraint.top),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constraint.right),
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint.left)
        ]
        
        if let bottom = constraint.bottom {
            constraints.append(childView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottom))
        }
        
        if let height = constraint.height {
            constraints.append(childView.heightAnchor.constraint(equalToConstant: height))
        }
        
        if let width = constraint.width {
            constraints.append(childView.widthAnchor.constraint(equalToConstant: width))
        }
        
        [constraints]
        .forEach(NSLayoutConstraint.activate(_:))
    }
}

import Kingfisher

extension UIImageView {
    func loadImage(from url: URL) {
                 
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "mario"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
