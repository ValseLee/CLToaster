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
 - Properties: Animation
 */
public struct CLToastAnimations {
  /**
   Flag determines ToastView to animate.
   Its value is ``true`` by default.
   */
  public var isAnimationEnabled = true
  
  /**
   Display ToastView from given section value.
   */
  public var animateFrom: CLToastDisplaySection = .top
  
  /**
   Display ToastView for its value.
   */
  public var displayTime: TimeInterval = 1.0
  
  /**
   Animate ToastView's offset with its value.
   
   It automatically adjust offset's value depends on ``displayFrom``.
   If ``displayFrom`` is ``.top``, ToastView will animate from top with
   ``animateY`` value.
   If ``displayFrom`` is ``.bottom``, ToastViwe will animate from bottom with ``animateY`` value.
   */
  public var offsetY: CGFloat = 40
  
  /**
   Animate ToastView's opacity with its value.
   Its value is ``1.0`` by default.
   */
  public var opacity: Float = 1.0
  
  /**
   Animate ToastView with given speed.
   */
  public var animationSpeed: TimeInterval = 0.3
  
  /**
   Initialize ``CLToastAnimation`` with default protperty value.
   You can customize any properties with your taste with Proprety DI.
   */
  public init() { }
}
