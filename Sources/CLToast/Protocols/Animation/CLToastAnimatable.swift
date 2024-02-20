//
//  CLToastAnimatable.swift
//
//
//  Created by Celan on 2/4/24.
//

import Foundation

/**
 It offers an Interface for animation customization.
 ``CLToastAnimation`` has a basic animation which is not concrete.
 When you want to customize whole animation, you sholud conform ``CLToastUIKitAnimation`` or ``CLToastSwiftUITransition``.
 Both of them are conforms ``CLToastAnimation``.
 
 ``CLAnimationInfo`` : Abstract type of Animation. In UIKit, it would be UIViewPropertyAnimator.
 
 ``toastAnimations`` : Animation model for internal usage.
 
 ``makeAnimation()`` : Make an animation which is need in both UIKit or SwiftUI. Returns ``CLAnimationInfo``.
*/
public protocol CLToastAnimation {
  associatedtype CLAnimationInfo
  var toastAnimations: CLToastAnimations { get }
  func makeAnimation() -> CLAnimationInfo
}

internal extension CLToastAnimation {
  func getAnimateOffset(for style: CLToastStyle) -> CGFloat {
    switch style.section {
    case .top: toastAnimations.offsetY
    case .bottom: -toastAnimations.offsetY
    case .center: toastAnimations.offsetY
    }
  }
  
  func getTransitionOffset(for style: CLToastStyle) -> CGFloat {
    switch style.section {
    case .top: -toastAnimations.offsetY
    case .bottom: toastAnimations.offsetY
    case .center: toastAnimations.offsetY
    }
  }
}
