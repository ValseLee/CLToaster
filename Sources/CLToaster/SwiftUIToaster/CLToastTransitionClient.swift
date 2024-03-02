//
//  CLToastTransitionClient.swift
//
//
//  Created by Celan on 2/13/24.
//

import Common
import SwiftUI

struct CLToastTransitionClient: CLToastSwiftUITransition {
  var toastAnimations: CLToastAnimations
  
  func makeInsertionTransition(for style: CLToastStyle) -> AnyTransition {
    AnyTransition
      .offset(y: getTransitionOffset(for: style))
      .combined(with: .opacity)
  }
  
  func makeRemovalTransition(for style: CLToastStyle) -> AnyTransition {
    AnyTransition
      .offset(y: getTransitionOffset(for: style))
      .combined(with: .opacity)
  }
  
  func makeAnimation() -> Animation {
    Animation
      .easeInOut(duration: toastAnimations.animationSpeed)
  }
}
