//
//  File.swift
//  
//
//  Created by Celan on 2/5/24.
//

import UIKit

extension UILabel {
  func setAlignment(to alignment: NSTextAlignment) -> Self {
    self.textAlignment = alignment
    return self
  }
  
  func setTitle(with text: String) -> Self {
    self.text = text
    return self
  }
  
  func setMultiline(with count: Int) -> Self {
    self.numberOfLines = count
    return self
  }
  
  func setFont(with style: UIFont.TextStyle) -> Self {
    self.font = UIFont.preferredFont(forTextStyle: style)
    return self
  }
}
