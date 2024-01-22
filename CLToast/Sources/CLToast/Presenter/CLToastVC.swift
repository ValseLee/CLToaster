//
//  CLToastVC.swift
//  
//
//  Created by Celan on 1/22/24.
//

import UIKit

final class CLToastVC: UIViewController {
  lazy var toastView = { CLToastView() }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addDismissTapGesture()
    config()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animate()
  }
  
  internal init(
    icon: UIImage,
    message: String,
    padding: CGFloat = 20
  ) {
    super.init(nibName: nil, bundle: nil)
    toastView.set(icon: icon, message: message, padding: padding)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func animate() {
    UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveEaseOut) { [weak self] in
      guard let self else { return }
      toastView.frame.origin.y += 40
      toastView.layer.opacity = 1.0
      
    } completion: { isAnimated in
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) { [weak self] in
        guard let self else { return }
        self.dismissToastVC()
      }
    }
  }
  
  private func addDismissTapGesture() {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissToastVC))
    self.view.addGestureRecognizer(gesture)
  }
  
  @objc
  private func dismissToastVC() {
    UIView.animate(withDuration: 0.75) { [weak self] in
      guard let self else { return }
      toastView.layer.opacity = 0.0
      
    } completion: { isAnimated in
      self.removeVC(isAnimated: isAnimated)
    }
  }
  
  private func removeVC(isAnimated: Bool) {
    if isAnimated,
       self.parent != nil {
      self.removeFromParent()
      self.view.removeFromSuperview()
      self.dismiss(animated: true)
    }
  }
}

extension CLToastVC {
  private func config() {
    view.addSubview(toastView)
    toastView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      toastView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
      toastView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    ])
  }
}
