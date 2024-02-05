//
//  CLToastDefaultVC.swift
//
//
//  Created by Celan on 1/22/24.
//

import UIKit

final class CLToastDefaultVC: UIViewController, CLToastPresentable {
  var animationDelegate: (CLToastAnimatable)?
  var onDismiss: (() -> Void)?
  var toastView: UIView = {
    let toast = CLToastView()
    toast.set(icon: .actions, message: "Hi")
    return toast
  }()
  
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
  
  internal func configToastView() {
    view.addSubview(toastView)
    toastView.backgroundColor = .red
    toastView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      toastView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
      toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      toastView.heightAnchor.constraint(equalToConstant: 70)
    ])
  }
  
  private func removeVC(isAnimated: Bool) {
    if isAnimated {
      removeFromParent()
      view.removeFromSuperview()
      dismiss(animated: true, completion: onDismiss)
    }
  }
}
