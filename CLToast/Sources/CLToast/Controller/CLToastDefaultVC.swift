//
//  CLToastDefaultVC.swift
//
//
//  Created by Celan on 1/22/24.
//

import UIKit

final class CLToastDefaultVC: UIViewController, CLToastPresentable {
  var animationDelegate: (CLToastAnimatable)?
  var toastView: UIView = CLToastView()
  var onDismiss: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    animationDelegate?.animate(for: toastView, completion: removeVC(isAnimated:))
  }
  
  internal func present(in parent: UIViewController) {
    Task { @MainActor [weak parent, weak self] in
      guard let self, let parent else { return }
      parent.addChild(self)
      parent.view.addSubview(toastView)
      didMove(toParent: parent)
      toastView.frame = parent.view.bounds
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
