//
//  CLToastView.swift
//  
//
//  Created by Celan on 1/22/24.
//

import UIKit

final class CLToastView: UIView {
  private let iconImageView = UIImageView()
  private let toastMessageLabel = UILabel()
  private var padding: CGFloat = 20
  
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
    message: String,
    padding: CGFloat = 20
  ) {
    iconImageView.image = icon
    toastMessageLabel.text = message
    self.padding = padding
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
    iconImageView.translatesAutoresizingMaskIntoConstraints = false
    iconImageView.render()
    
    NSLayoutConstraint.activate([
      iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
  
  private func configToastMessageLabel() {
    addSubview(toastMessageLabel)
    toastMessageLabel.translatesAutoresizingMaskIntoConstraints = false
    toastMessageLabel.numberOfLines = 1
    toastMessageLabel.textAlignment = .left
    
    NSLayoutConstraint.activate([
      toastMessageLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
      toastMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      toastMessageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
}
