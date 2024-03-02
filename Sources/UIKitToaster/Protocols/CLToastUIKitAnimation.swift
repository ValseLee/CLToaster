//
//  CLToastUIKitAnimation.swift
//
//
//  Created by Celan on 2/19/24.
//

import Common
import UIKit

/**
 Customize your animation with ``CLToastUIKitAnimation``.
 ``CLToastUIKitAnimation`` also conforms ``CLToastAnimation``, so it needs ``CLToastAnimations``.
 
 Each animation is triggered by this framework internally like below.
 toastView's removal from superview is managed also.
 ```swift
  func animate(_ toastView: UIView) {
    if
    let appearingAnimation = animationManager.makeAnimation() as? UIViewPropertyAnimator,
    let disappearingAnimation = animationManager.makeAnimation() as? UIViewPropertyAnimator {
      appearingAnimation.buildAnimation {
      animationManager
        .makeAppearingAnimation(toastView: toastView, for: style)
      }
      .addCompletion { state in
        if case .end = state {
          disappearingAnimation
            .startAnimation(afterDelay: animationManager.toastAnimations.displayTime)
        }
    }

    disappearingAnimation.buildAnimation {
      animationManager.makeDisappearingAnimation(toastView: toastView, for: style)
    }
    .addCompletion { state  in
      if case .end = state {
        toastView.removeFromSuperview()
      }
    }

    appearingAnimation.startAnimation()
    }
  }
 ```
 
 ``makeAppearingAnimation(toastView:for:)`` : 
 
 ``makeDisappearingAnimation(toastView:for:)`` :
 */
public protocol CLToastUIKitAnimation: CLToastAnimation {
  
  /**
   Make appearing Animation.
   - Parameters:
     - toastView: target view for appearing animate. Injected by framework.
     - style: ``CLToastStyle`` for internal usage.
   
   Although ``CLToastUIKitAnimation`` implementation requires a ``CLToastAnimations``, but when you customize, you don't have to refer that.
   You can just animate toastView's layer or frame like below.
   ```swift
   func makeAppearingAnimation(toastView: UIView, for style: CLToastStyle) {
     toastView.layer.opacity = toastAnimations.opacity
     toastView.frame.origin.y += toastAnimations.offsetY
     toastView.frame.origin.x += 40
   }
   ```
   */
  func makeAppearingAnimation(toastView: UIView, for style: CLToastStyle)
  
  /**
   Make disappearing Animation.
   - Parameters:
     - toastView: target view for disappearing animate. Injected by framework.
     - style: ``CLToastStyle`` for internal usage.
   */
  func makeDisappearingAnimation(toastView: UIView, for style: CLToastStyle)
}
