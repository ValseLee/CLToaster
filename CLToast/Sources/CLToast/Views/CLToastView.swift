//
//  CLToastView.swift
//  
//
//  Created by Celan on 1/22/24.
//

import UIKit

public class CLToastView: UIView {
  var titleLabel: UILabel?
  
  func configLayer(
    cornerRadius: CGFloat,
    opacity: Float,
    backgroundColor: UIColor
  ) {
    layer.cornerRadius = cornerRadius
    layer.opacity = opacity
    self.backgroundColor = backgroundColor
  }
  
  func makeSubviews() {
    let container = CLToastViewFieldContainer(of: self)
    var builderA = CLToastViewBuilder(of: container)
   
    builderA.makeLabel(for: \.toastView.titleLabel) { [weak self] in
      guard let self else { return nil }
      let label = UILabel()
        .setFont(with: .title3)
        .setTitle(with: "HiHi")
        .setAlignment(to: .left)
    
      self.addSubview(label)
    
      NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
      ])
      return label
    }
  }
}
