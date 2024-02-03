//
//  CLToastMessageView.swift
//  
//
//  Created by Celan on 1/22/24.
//

import UIKit

internal final class CLToastMessageLabel: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init() {
    self.init(frame: .zero)
    configToastMessageLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configToastMessageLabel() {
    translatesAutoresizingMaskIntoConstraints = false
    numberOfLines = 1
    textAlignment = .left
  }
}
