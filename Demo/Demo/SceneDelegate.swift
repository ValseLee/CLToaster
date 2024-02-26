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
    let uikitController = CLToastDemoVC()
    uikitController.title = "UIKit"
    uikitController.tabBarItem.image = UIImage(systemName: "circle")
    
    let swiftUIController = SwiftUIController()
    swiftUIController.title = "SwiftUI"
    swiftUIController.tabBarItem.image = UIImage(systemName: "circle")
    
    let tab = UITabBarController()
    let uikitNav = UINavigationController(rootViewController: uikitController)
    let swiftuiNav = UINavigationController(rootViewController: swiftUIController)
    
    tab.setViewControllers([uikitNav, swiftuiNav], animated: false)
    window?.rootViewController = tab
    window?.makeKeyAndVisible()
  }
}
