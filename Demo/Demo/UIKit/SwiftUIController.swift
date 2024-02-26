//
//  SwiftUIController.swift
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
      swiftUIView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      swiftUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      swiftUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      swiftUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    ])
    
    vc.didMove(toParent: self)
    view.backgroundColor = .systemBackground
  }
}
