//
//  File.swift
//  
//
//  Created by Celan on 1/22/24.
//

import UIKit

public struct CLToastStyle {
  /**
   - Properties: ToastView's Layer & Background
   */
  
  public var layerOpacity: Float = 0.3
  public var layerCornerRadius: CGFloat = 16
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
  public var imageSize: CGSize = CGSize.IconSizes.default
  
  public init(title: String) {
    self.title = title
  }
}
