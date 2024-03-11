//
//  CLToastUIKitAnimator.swift
//  
//
//  Created by Celan on 3/2/24.
//

import UIKit

protocol UIKitToastAnimator {
  var animation: any CLToastUIKitAnimation { get }
  var gesture: any CLToastUIKitTapGesture { get }
  func animate(_ toastView: UIView, with style: CLToastStyle)
}

// Internal Animator
struct CLToastUIKitAnimator: UIKitToastAnimator {
  var animation: any CLToastUIKitAnimation
  var gesture: any CLToastUIKitTapGesture
  
  func animate(_ toastView: UIView, with style: CLToastStyle) {
    if
      let appearingAnimation = animation.makeAnimation() as? UIViewPropertyAnimator,
      let disappearingAnimation = animation.makeAnimation() as? UIViewPropertyAnimator {
      let displayTime = DispatchTime.now()
      + animation.toastAnimations.displayTime
      + animation.toastAnimations.animationSpeed
      
      toastView.isUserInteractionEnabled = true
      
      gesture.makeTapGesture(for: toastView) {
        appearingAnimation.stopAnimation(false)
        disappearingAnimation.startAnimation()
      }
      
      appearingAnimation
        .addAnimations {
          animation.makeAppearingAnimation(toastView: toastView, for: style)
        }
      
      disappearingAnimation
        .addAnimations {
          animation.makeDisappearingAnimation(toastView: toastView, for: style)
        }
      
      disappearingAnimation
        .addCompletion { state in
          if case .end = state { toastView.removeFromSuperview() }
        }
      
      appearingAnimation.startAnimation()
      
      DispatchQueue.main.asyncAfter(deadline: displayTime) {
        disappearingAnimation.startAnimation()
      }
    }
  }
}
