//
//  CLToastTransitionClient.swift
//
//
//  Created by Celan on 2/13/24.
//

import SwiftUI

struct CLToastTransitionClient: CLToastAnimation {
  typealias CLAnimationEnvironment = SwiftUITransition
  
  func makeAnimation(with style: CLToastStyle) -> AnyTransition {
    AnyTransition.opacity
//      .offset(y: getTransitionOffset(from: style))
//      .combined(with: .opacity)
  }
}
