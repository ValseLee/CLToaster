//
//  File.swift
//  
//
//  Created by Celan on 1/22/24.
//

import UIKit

public struct CLToastStyle {
  public init(title: String) {
    self.title = title
  }
  
  public init(
    layerOpacity: Float,
    layerCornerRadius: CGFloat,
    title: String,
    description: String? = nil,
    timeline: String? = nil,
    image: UIImage? = nil,
    displayTimeInterval: TimeInterval,
    displayFrom: CLToastDisplaySection,
    animateY: CGFloat,
    animateOpacity: Float
  ) {
    self.layerOpacity = layerOpacity
    self.layerCornerRadius = layerCornerRadius
    self.title = title
    self.description = description
    self.timeline = timeline
    self.image = image
    self.displayTimeInterval = displayTimeInterval
    self.displayFrom = displayFrom
    self.animateY = animateY
    self.animateOpacity = animateOpacity
  }
  
  /**
   - Properties: ToastView's Layer & Background
   */
  
  public var layerOpacity: Float = 0.3
  public var layerCornerRadius: CGFloat = 12
  public var height: CGFloat = 100
  public var backgroundColor: UIColor = .systemGray2
  
  /**
   - Properties: ToastView
   ToastView title is required.
   */
  
  
  public var title: String
  public var description: String?
  public var timeline: String?
  public var image: UIImage?
  public var imageSize: CGSize? = CGSize.IconSizes.default
  
  /**
   - Properties: Animation
   */
  
  /**
   Display ToastView for its value.
   */
  public var displayTimeInterval: TimeInterval = 1.0
  public var displayFrom: CLToastDisplaySection = .top
  
  /**
   Animate ToastView's offset with its value.
   
   It automatically adjust offset's value depends on ``displayFrom``.
   If ``displayFrom`` is ``.top``, ToastView will animate from top with
   ``animateY`` value.
   If ``displayFrom`` is ``.bottom``, ToastViwe will animate from bottom with ``animateY`` value.
   */
  public var animateY: CGFloat = 40
  
  /**
   Animate ToastView's Opacity with its value.
   */
  public var animateOpacity: Float = 1.0
  
  /**
   Animate ToastView with given speed.
   */
  public var animateSpeed: TimeInterval = 0.3
  
  /**
   Flag determines ToastView to animate.
   */
  public var isAnimateEnabled: Bool = false
}

public enum CLToastDisplaySection {
  case top, bottom, center
}
