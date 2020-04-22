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
}

protocol Transitionable:class {
    associatedtype StateType
    func push(to newState: StateType)
    func display(to newState: StateType)
    func showAlert(title: String, message: String, completionHandler: ((String?)->Void)?)
    func dismiss()
}

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
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
}
