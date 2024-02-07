//
//  CLToastDefaultVC.swift
//
//
//  Created by Celan on 1/22/24.
//

import UIKit

internal class CLToastDefaultVC: UIViewController, CLToastPresentable {
  typealias CLToastViewType = CLToastView
  
  var animationDelegate: (CLToastAnimatable)?
  var onDismiss: (() -> Void)?
  var toastView: CLToastViewType = CLToastView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configToastView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animationDelegate?.animate(
      for: toastView,
      completion: removeVC(isAnimated:)
    )
  }
  
  func configToastView() {
    toastView.configLayer(cornerRadius: 20, opacity: 0.0, backgroundColor: .systemGray4)
    toastView.makeSubviews()
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
