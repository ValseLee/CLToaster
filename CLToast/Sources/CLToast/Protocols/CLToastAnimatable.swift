//
//  CLToastAnimatable.swift
//
//
//  Created by Celan on 2/4/24.
//

import UIKit

public protocol CLToastAnimation {
  associatedtype CLAnimationInfo
  var toastAnimations: CLToastAnimations { get }
  func makeAnimation() -> CLAnimationInfo
}

extension CLToastAnimation {
  func getAnimateOffset() -> CGFloat {
    switch toastAnimations.animateFrom {
    case .top: toastAnimations.offsetY
    case .bottom: -toastAnimations.offsetY
    case .center: toastAnimations.offsetY
    }
  }
  
  func getTransitionOffset() -> CGFloat {
    switch toastAnimations.animateFrom {
    case .top: -toastAnimations.offsetY
    case .bottom: toastAnimations.offsetY
    case .center: toastAnimations.offsetY
    }
  }
}
