//
//  CLToastSwiftUIAnimation.swift
//
//
//  Created by Celan on 2/19/24.
//

import SwiftUI

public protocol CLToastSwiftUIAnimation: CLToastAnimation {
  func makeInsertionTransition() -> AnyTransition
  func makeRemovalTransition() -> AnyTransition
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
