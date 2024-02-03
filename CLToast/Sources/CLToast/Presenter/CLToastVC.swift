//
//  CLToastVC.swift
//  
//
//  Created by Celan on 1/22/24.
//

import UIKit

final class CLToastVC: UIViewController, CLToastPresentable {
  public var onDismiss: (() -> Void)?
  internal var style: CLToastStyle?
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    addDismissTapGesture()
    config()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animate()
  }
  
  internal init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  private func addDismissTapGesture() {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissCLToast))
    self.view.addGestureRecognizer(gesture)
  }
  
  @objc
  internal func dismissCLToast() {
    UIView.animate(withDuration: 0.75) { [weak self] in
      guard let self else { return }
      if let toastView = self.view.subviews.first {
        toastView.layer.opacity = 0.0
      }
      
    } completion: { [weak self] isAnimated in
      guard let self else { return }
      self.removeCLToastVC(isAnimated: isAnimated)
    }
  }
  
  private func removeCLToastVC(isAnimated: Bool) {
    if isAnimated,
       self.parent != nil {
      self.removeFromParent()
      self.view.removeFromSuperview()
      self.dismiss(animated: true, completion: onDismiss)
    }
  }
}

// MARK: - Rendering
extension CLToastVC {
  private func config() {
    let toastView = CLToastView()
    
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
