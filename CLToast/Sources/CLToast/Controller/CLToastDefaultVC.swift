//
//  CLToastDefaultVC.swift
//
//
//  Created by Celan on 1/22/24.
//

import UIKit

internal class CLToastDefaultVC: UIViewController, CLToastPresentable {
  var animationDelegate: (CLToastAnimatable)?
  var onDismiss: (() -> Void)?
  weak var toastView: UIView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configToastView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    guard let toastView else { return }
    animationDelegate?.animate(
      for: toastView,
      completion: removeVC(isAnimated:)
    )
  }
  
  func configToastView() {
    guard let toastView else { return }
    toastView.layer.cornerRadius = 20
    toastView.layer.opacity = 0.0
    toastView.backgroundColor = .systemGray4
    
    view.addSubview(toastView)
    toastView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      toastView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
      toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      toastView.heightAnchor.constraint(equalToConstant: 100)
    ])
  }
  
  func removeVC(isAnimated: Bool) {
    if isAnimated {
      removeFromParent()
      view.removeFromSuperview()
      dismiss(animated: true, completion: onDismiss)
    }
  }
}
