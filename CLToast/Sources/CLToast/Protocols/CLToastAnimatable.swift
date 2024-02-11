//
//  CLToastAnimatable.swift
//
//
//  Created by Celan on 2/4/24.
//

import UIKit

public protocol CLToastAnimatable {
  var style: CLToastStyle { get }
  func animate(for view: UIView, completion: @escaping () -> Void)
}

struct CLToastAnimateClient: CLToastAnimatable {
  let style: CLToastStyle
  
  /// Trigger toastView's Animation with given ``CLToastStyle``.
  /// - Parameters:
  ///   - view: 애니메이션을 동작할 Toast Message View를 전달합니다.
  ///   - completion: 애니메이션이 완전히 종료된 후 호출할 메소드를 전달합니다.
  func animate(for view: UIView, completion: @escaping () -> Void) {
    guard style.isAnimationEnabled else { return }
    let appearingAnimation = makeAppearingAnimation(for: view)
    let disappearingAnimation = makeDisappearingAnimation(for: view, didDisappear: completion)
    
    appearingAnimation.addCompletion { currentState in
      guard case .end = currentState else { return }
      disappearingAnimation.startAnimation(afterDelay: style.displayTimeInterval)
    }
    
    appearingAnimation.startAnimation()
  }
}

fileprivate extension CLToastAnimateClient {
  func makeAppearingAnimation(for toastView: UIView) -> UIViewPropertyAnimator {
    UIViewPropertyAnimator(
      duration: style.animateSpeed,
      curve: .easeInOut
    ) {
      toastView.frame.origin.y += getAnimateOffset()
      toastView.layer.opacity = style.animateOpacity
    }
  }
  
  func makeDisappearingAnimation(
    for toastView: UIView,
    didDisappear: @escaping () -> Void
  ) -> UIViewPropertyAnimator {
    let animation = UIViewPropertyAnimator(
      duration: style.animateSpeed,
      curve: .easeInOut
    ) {
      toastView.frame.origin.y -= getAnimateOffset()
      toastView.layer.opacity = 0.0
    }
    
    animation.addCompletion { currentState in
      guard case .end = currentState else { return }
      didDisappear()
      toastView.removeFromSuperview()
    }
    return animation
  }
  
  func getAnimateOffset() -> CGFloat {
    switch style.displayFrom {
    case .top:
      style.animateY
    case .bottom:
      -style.animateY
    case .center:
      CGFloat.zero
    }
  }
}
