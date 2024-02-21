//
//  SceneDelegate.swift
//  Demo
//
//  Created by Celan on 1/22/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    let demoVC = CLToastDemoVC()
    demoVC.tabBarItem.image = UIImage(systemName: "circle")
    
    let emptyVC = EmptyVC()
    emptyVC.title = "Demo"
    emptyVC.tabBarItem.image = UIImage(systemName: "circle")
    
    let tab = UITabBarController()
    let nav = UINavigationController(rootViewController: demoVC)
    tab.setViewControllers([nav, emptyVC], animated: false)
    window?.rootViewController = tab
    window?.makeKeyAndVisible()
  }
}
