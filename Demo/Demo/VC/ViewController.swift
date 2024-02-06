//
//  ViewController.swift
//  Demo
//
//  Created by Celan on 1/22/24.
//

import CLToast
import UIKit

final class CLToastDemoVC: UIViewController {
  let button: UIButton = {
    let btn = UIButton()
    btn.setTitle("Present", for: .normal)
    btn.setTitleColor(.systemPink, for: .normal)
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(true, animated: false)
    title = "MAIN"
    view.backgroundColor = .yellow
    
    view.addSubview(button)
    button.addTarget(self, action: #selector(presentToast), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      button.heightAnchor.constraint(equalToConstant: 100),
      button.widthAnchor.constraint(equalToConstant: 100),
    ])
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  @objc
  private func presentToast() {
    let navigationToast = CLToast<OverNavigationBar>()
    navigationToast.present(in: self)
    
//    let vcToast = CLToast<OverViewController>()
//    vcToast.present(in: self)
  }
}

