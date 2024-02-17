//
//  CLToastTransitionClient.swift
//
//
//  Created by Celan on 2/13/24.
//

import SwiftUI

public protocol CLToastSwiftUIAnimation: CLToastAnimation {
  func makeTransition() -> AnyTransition
}

internal extension CLToastSwiftUIAnimation {
  var animateFrom: Alignment {
    switch toastAnimations.animateFrom {
    case .top: return .top
    case .bottom: return .bottom
    case .center: return .center
    }
  }
}

struct CLToastTransitionClient: CLToastSwiftUIAnimation {
  var toastAnimations = CLToastAnimations()
  
  func makeTransition() -> AnyTransition {
    AnyTransition
      .offset(y: getTransitionOffset())
      .combined(with: .opacity)
  }
  
  func makeAnimation() -> Animation {
    Animation.easeInOut(duration: toastAnimations.animationSpeed)
  }
}
