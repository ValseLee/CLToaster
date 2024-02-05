//
//  File.swift
//  
//
//  Created by Celan on 2/5/24.
//

import UIKit

extension UIImageView {
  public func render(with size: CGSize) {
    NSLayoutConstraint.activate([
      self.widthAnchor.constraint(equalToConstant: size.width),
      self.heightAnchor.constraint(equalToConstant: size.height),
    ])
  }

  func setImage(with image: UIImage) -> Self {
    self.image = image
    return self
  }
  
  func setImageSize(with size: CGSize) -> Self {
    self.render(with: size)
    return self
  }
}
