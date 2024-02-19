//
//  File.swift
//  
//
//  Created by Celan on 1/22/24.
//

import UIKit

public struct CLToastStyle {
  /**
   Display ToastView from given section value.
   Default value is ``.top``.
   */
  var section: CLToastDisplaySection = .top
  
  /**
   - Properties: ToastView's Layer & Background
   */
  
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
  
  /**
   Initialize ``CLToastStyle`` with given title.
   You can assign values to properties with your own taste.
   ToastView will be composed with ``CLToastStyle``'s own properties.
   
   - Parameter title: Toast Message's main title.
   */
  public init(title: String) {
    self.title = title
  }
}
