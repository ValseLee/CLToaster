//
//  CLToastView.swift
//  
//
//  Created by Celan on 1/22/24.
//

import UIKit

final class CLToastView: UIView {
  internal var iconImageView = CLToastIconView()
  internal var toastMessageLabel = CLToastMessageLabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configToastViewLayer()
    configIconImageView()
    configToastMessageLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func set(
    icon: UIImage,
    message: String
  ) {
    iconImageView.image = icon
    toastMessageLabel.text = message
  }
}

// MARK: - Rendering
extension CLToastView {
  private func configToastViewLayer() {
    layer.cornerRadius = 20
    layer.opacity = 0.0
    
    if #available(iOS 13.0, *) {
      backgroundColor = .secondarySystemBackground
    } else {
      backgroundColor = .gray
    }
  }
  
  private func configIconImageView() {
    addSubview(iconImageView)
    iconImageView.render(with: .IconSizes.default)
    
    NSLayoutConstraint.activate([
      iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.Padding.default),
      iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
  
  private func configToastMessageLabel() {
    addSubview(toastMessageLabel)

    NSLayoutConstraint.activate([
      toastMessageLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
      toastMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat.Padding.default),
      toastMessageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
}
