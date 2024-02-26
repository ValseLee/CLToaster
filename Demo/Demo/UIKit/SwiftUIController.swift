//
//  EmptyVC.swift
//  Demo
//
//  Created by Celan on 2/21/24.
//

import UIKit
import SwiftUI

class SwiftUIController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let vc = UIHostingController(rootView: CLSwiftUIView())
    let swiftUIView = vc.view!
    swiftUIView.translatesAutoresizingMaskIntoConstraints = false
    addChild(vc)
    view.addSubview(swiftUIView)
    
    NSLayoutConstraint.activate([
      swiftUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      swiftUIView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
    
    vc.didMove(toParent: self)
    view.backgroundColor = .systemBackground
  }
}
