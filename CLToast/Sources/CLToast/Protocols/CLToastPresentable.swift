//
//  View.Layer.swift
//
//
//  Created by Celan on 1/22/24.
//

import UIKit

protocol CLToastPresentable: UIViewController {
  var onDismiss: (() -> Void)? { get set }
  var style: CLToastStyle? { get set }
  func animate()
  func dismissCLToast()
}

extension CLToastPresentable {
  internal func animate() {
    UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveEaseOut) { [weak self] in
      guard let self else { return }
      if let toastView = self.view.subviews.first {
        toastView.frame.origin.y += 40
        toastView.layer.opacity = 1.0
      }
    } completion: { isAnimated in
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) { [weak self] in
        guard let self else { return }
        self.dismissCLToast()
      }
    }
  }
  
  private func removeVC(isAnimated: Bool) {
    if isAnimated,
       self.parent != nil {
      self.removeFromParent()
      self.view.removeFromSuperview()
      self.dismiss(animated: true, completion: onDismiss)
    }
  }
}
