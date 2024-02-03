//
//  CLToastInfo.swift
//
//
//  Created by Celan on 1/22/24.
//

import UIKit

public struct CLToastInfo {
  let icon: UIImage
  let message: String
  let padding: CGFloat
  
  public init(
    icon: UIImage,
    message: String,
    padding: CGFloat = 20
  ) {
    self.icon = icon
    self.message = message
    self.padding = padding
  }
}
