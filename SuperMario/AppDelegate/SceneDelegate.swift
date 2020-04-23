//
//  SceneDelegate.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  
        guard let windowScene = (scene as? UIWindowScene) else { return }
               
               let root = BaseNavigationViewController(rootViewController: RootViewController())
               
               let window = UIWindow(windowScene: windowScene)
               window.rootViewController = root
               
               self.window = window
               window.makeKeyAndVisible()
    }
}
