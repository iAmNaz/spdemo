//
//  UIKit+Extensions.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit

/// This is just a fancy way of assigning values to the subclass of the
/// UITableViewCell without indicating the concrete type
extension UITableViewCell {
    
    /// The concrete model of the cell
    var model: RowModel {
        get {
            return (self as! Cell).rowModel
        }
        set {
            var row = (self as! Cell)
            row.rowModel = newValue
        }
    }
    
    /// The action invoked when the thumbnail is tapped
    var previewAction: ((RowModel) -> Void)? {
        get {
            return (self as! Cell).characterPreViewAction
        }
        set {
            var row = (self as! Cell)
            row.characterPreViewAction = newValue
        }
    }
    
    /// The action invoked when the information area is tapped
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

/// A protocol comformed by viewController classes.
/// This is the boundary between the view model and the controller
protocol Transitionable:class {
    
    /// Typically an enum with different screen states or actions
    associatedtype State
    
    /// Call this for pushing view controllers in the navigation stack
    /// - Parameter to: To a given state
    func push(to newState: State)
    
    /// Call this for displaying other views in the same screen
    /// - Parameter to: To a given state
    func display(to newState: State)
    
    /// A general purpose alert view
    /// - Parameter title: Title of the the alert
    /// - Parameter message: The alert message
    func showAlert(title: String, message: String)
}

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let submitAction = UIAlertAction(title: "OK", style: .default) { _ in
                
                ac.dismiss(animated: true, completion: nil)
            }
            ac.addAction(submitAction)
        
        if let vc = self.navigationController?.visibleViewController {
            vc.present(ac, animated: true)
        }
    }
    
    /// Show a text progress status
    func showProgressIndicator() {
        self.title = "Loading..."
    }
    
    /// Unset the progress status
    func hideProgressIndicator(title: String) {
        self.title = title
    }
    
    /// A helper method to add child views and simple constraints
    /// - Parameter childView: The view to be added as sub view
    /// - Parameter constratin: A struct containing constraint constant values
    func addView(childView: UIView, constraint: ConstraintValues) {
        
        view.addSubview(childView)
    
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        applyConstraints(forView: childView, constraint: constraint)
    }
    
    /// Helps build and apply the view constraints
    /// - Parameter forView: The sub view
    /// - Parameter constraint: The struct with constraint constant values
    func applyConstraints(forView childView: UIView, constraint: ConstraintValues) {
        
        var constraints = [NSLayoutConstraint]()
        
        if let right = constraint.right {
            constraints.append(childView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: right))
        }
        
        if let left = constraint.left {
            constraints.append(childView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: left))
        }
        
        if let top = constraint.top {
            constraints.append(childView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: top))
        }
        
        if let bottom = constraint.bottom {
            constraints.append(childView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottom))
        }
        
        if let height = constraint.height {
            constraints.append(childView.heightAnchor.constraint(equalToConstant: height))
        }
        
        if let width = constraint.width {
            constraints.append(childView.widthAnchor.constraint(equalToConstant: width))
        }
        
        if let centerX = constraint.centerX {
            constraints.append(childView.centerXAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor, constant: centerX))
        }
        
        if let centerY = constraint.centerY {
            constraints.append(childView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY))
        }
        
        [constraints]
        .forEach(NSLayoutConstraint.activate(_:))
    }
}

import Kingfisher

extension UIImageView {
    /// Asynchronously load remote images using this method.
    /// When invoked it will initially display a given placeholder image and activity indicator.
    /// When the image loads the placeholder will be replaced with the remote image and
    /// the activity indicator will be hidden.
    /// 
    /// - Parameter url: The url of an image
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
