//
//  UILabel+Builder.swift
//  
//
//  Created by Celan on 2/5/24.
//

import UIKit

extension UILabel {
  @discardableResult
  func setAlignment(to alignment: NSTextAlignment) -> Self {
    self.textAlignment = alignment
    return self
  }
  
  @discardableResult
  func setTitle(with text: String) -> Self {
    self.text = text
    return self
  }
  
  @discardableResult
  func setMultiline(with count: Int) -> Self {
    self.numberOfLines = count
    return self
  }
  
  @discardableResult
  func setFont(with style: UIFont.TextStyle) -> Self {
    self.font = UIFont.preferredFont(forTextStyle: style)
    return self
  }
  
  @discardableResult
  func setIdentifier(with id: String) -> Self {
    self.accessibilityIdentifier = id
    return self
  }
  
  @discardableResult
  func setColor(with color: UIColor) -> Self {
    self.textColor = color
    return self
  }
  
  @discardableResult
  func configAutoLayout() -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    return self
  }
}
