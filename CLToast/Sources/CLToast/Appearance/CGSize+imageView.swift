//
//  File.swift
//  
//
//  Created by Celan on 1/22/24.
//

import UIKit

extension UIImageView {
  public func render(with size: CGSize) {
    NSLayoutConstraint.activate([
      self.widthAnchor.constraint(equalToConstant: size.width),
      self.heightAnchor.constraint(equalToConstant: size.height),
    ])
  }
}

extension CGSize {
  public struct IconSizes {
    public static var `default` = CGSize(width: 16, height: 16)
    /// 20 x 20
    public static var small = CGSize(width: 20, height: 20)
    /// 24 x 24
    public static var medium = CGSize(width: 24, height: 24)
    /// 36 x 36
    public static var large = CGSize(width: 36, height: 36)
  }
}
