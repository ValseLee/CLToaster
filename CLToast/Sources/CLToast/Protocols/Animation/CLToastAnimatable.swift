//
//  CLToastAnimatable.swift
//
//
//  Created by Celan on 2/4/24.
//

import Foundation

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
