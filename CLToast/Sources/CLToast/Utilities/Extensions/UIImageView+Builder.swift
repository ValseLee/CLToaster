//
//  File.swift
//  
//
//  Created by Celan on 2/5/24.
//

import UIKit

extension UIImageView {
  @discardableResult
  func setImage(with image: UIImage?) -> Self {
    self.image = image
    return self
  }
  
  @discardableResult
  func setIdentifier(with id: String) -> Self {
    self.accessibilityIdentifier = id
    return self
  }
  
  @discardableResult
  func configAutoLayout() -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    return self
  }
}
