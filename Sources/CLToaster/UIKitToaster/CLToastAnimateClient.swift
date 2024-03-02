//
//  CLToastAnimateClient.swift
//  
//
//  Created by Celan on 2/13/24.
//

import Common
import UIKit

public struct CLToastUIKitAnimationClient: CLToastUIKitAnimation {
  public let toastAnimations: CLToastAnimations
  
  public init(toastAnimations: CLToastAnimations) {
    self.toastAnimations = toastAnimations
  }
  
  public func makeAppearingAnimation(toastView: UIView, for style: CLToastStyle) {
    toastView.layer.opacity = toastAnimations.opacity
    toastView.frame.origin.y += getAnimateOffset(for: style)
  }
  
  public func makeDisappearingAnimation(toastView: UIView, for style: CLToastStyle) {
    toastView.layer.opacity = 0
    toastView.frame.origin.y -= getAnimateOffset(for: style)
  }
  
  public func makeAnimation() -> UIViewPropertyAnimator {
    UIViewPropertyAnimator(
      duration: toastAnimations.animationSpeed,
      curve: .easeInOut
    )
  }
}
