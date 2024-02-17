//
//  CLToastAnimateClient.swift
//  
//
//  Created by Celan on 2/13/24.
//

import UIKit

public protocol CLToastUIKitAnimation: CLToastAnimation {
  func appearing(toastView: UIView)
  func disappearing(toastView: UIView)
}

struct CLToastUIKitAnimationClient: CLToastUIKitAnimation {
  let toastAnimations = CLToastAnimations()
  
  func appearing(toastView: UIView) {
    toastView.layer.opacity = toastAnimations.opacity
    toastView.frame.origin.y += getAnimateOffset()
  }
  
  func disappearing(toastView: UIView) {
    toastView.layer.opacity = 0
    toastView.frame.origin.y -= getAnimateOffset()
  }
  
  func makeAnimation() -> UIViewPropertyAnimator {
    UIViewPropertyAnimator(
      duration: toastAnimations.animationSpeed,
      curve: .easeInOut
    )
  }
}
