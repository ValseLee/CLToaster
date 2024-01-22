//
//  ViewController.swift
//  Demo
//
//  Created by Celan on 1/22/24.
//

import CLToast
import UIKit

final class CLToastDemoVC: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .yellow
    presentToast()
  }

  private func presentToast() {
    let toastManager = CLToast<OverViewController>(
      with: CLToastInfo(icon: .checkmark, message: "Hi")
    )
    
    toastManager.present(in: self)
  }
}

