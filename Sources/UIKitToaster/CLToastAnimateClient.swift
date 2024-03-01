//
//  CLToastAnimateClient.swift
//  
//
//  Created by Celan on 2/13/24.
//

import UIKit

struct CLToastUIKitAnimationClient: CLToastUIKitAnimation {
  let toastAnimations: CLToastAnimations
  
  func makeAppearingAnimation(toastView: UIView, for style: CLToastStyle) {
    toastView.layer.opacity = toastAnimations.opacity
    toastView.frame.origin.y += getAnimateOffset(for: style)
  }
  
  func makeDisappearingAnimation(toastView: UIView, for style: CLToastStyle) {
    toastView.layer.opacity = 0
    toastView.frame.origin.y -= getAnimateOffset(for: style)
  }
  
  func makeAnimation() -> UIViewPropertyAnimator {
    UIViewPropertyAnimator(
      duration: toastAnimations.animationSpeed,
      curve: .easeInOut
    )
  }
}
