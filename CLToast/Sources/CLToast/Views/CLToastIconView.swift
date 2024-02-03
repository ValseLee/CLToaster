//
//  CLToastIconView.swift
//  
//
//  Created by Celan on 1/22/24.
//

import UIKit

internal final class CLToastIconView: UIImageView {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init() {
    self.init(frame: .zero)
    configIconImageView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configIconImageView() {
    translatesAutoresizingMaskIntoConstraints = false
  }
}
