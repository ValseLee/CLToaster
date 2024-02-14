//
//  CLToastAnimatable.swift
//
//
//  Created by Celan on 2/4/24.
//

import UIKit
import SwiftUI

public protocol CLToastAnimation {
  associatedtype CLAnimationInfo
  var animator: (() -> Void)? { get set }
  func makeAnimation(with style: CLToastStyle) -> CLAnimationInfo
}

extension CLToastAnimation {
    func getAnimateOffset(from style: CLToastStyle) -> CGFloat {
      switch style.displayFrom {
      case .top: style.animateY
      case .bottom: -style.animateY
      case .center: style.animateY
      }
    }
  
  func getTransitionOffset(from style: CLToastStyle) -> CGFloat {
    switch style.displayFrom {
    case .top: -style.animateY
    case .bottom: style.animateY
    case .center: style.animateY
    }
  }
}
