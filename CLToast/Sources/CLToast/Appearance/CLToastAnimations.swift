//
//  CLToastAnimations.swift
//
//
//  Created by Celan on 2/16/24.
//

import UIKit

public enum CLToastDisplaySection {
  case top, bottom, center
}

/**
 Initialize ``CLToastAnimations`` when you want to customize your toastView's animation.
 It is a conformance of ``CLToastUIKitAnimation`` or ``CLToastSwiftUITransition``.
 */
public struct CLToastAnimations {
  /**
   Flag determines ToastView to animate.
   Default value is ``true``.
   */
  public var isAnimationEnabled = true
  
  /**
   Display ToastView for its value.
   Default value is ``1.0``.
   */
  public var displayTime: TimeInterval = 1.0
  
  /**
   Animate ToastView's offset with its value.
   
   It automatically adjust offset's value depends on ``displayFrom``.
   If ``displayFrom`` is ``.top``, ToastView will animate from top with
   ``offsetY`` value.
   If ``displayFrom`` is ``.bottom``, ToastView will animate from bottom with ``offsetY`` value.
   */
  public var offsetY: CGFloat = 40
  
  /**
   Animate ToastView's opacity to this value.
   If you want to make your toatsView clear, make this value less than 1.0.
   Default value is ``1.0``.
   */
  public var opacity: Float = 1.0
  
  /**
   Animate ToastView with given speed.
   Default value is ``0.3``.
   */
  public var animationSpeed: TimeInterval = 0.3
  
  /**
   Initialize ``CLToastAnimation`` with default protperty value.
   You can customize any properties with your taste with Proprety DI.
   */
  public init() { }
}
