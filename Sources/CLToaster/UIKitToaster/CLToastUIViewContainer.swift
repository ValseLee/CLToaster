//
//  CLToastUIViewContainer.swift
//
//
//  Created by Celan on 2/5/24.
//

import UIKit

class CLToastView: UIView {
  var completion: (() -> Void)?
  
  init(completion: (() -> Void)? = nil) {
    super.init(frame: .zero)
    self.completion = completion
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func removeFromSuperview() {
    super.removeFromSuperview()
    guard let completion else { return }
    completion()
  }
}

struct CLToastUIViewContainer {
  var style: CLToastStyle
  var toastView: CLToastView = CLToastView()
  
  func addComponents(in section: CLToastViewSection) -> UIView? {
    switch section {
    case .title:
      let label = UILabel()
        .configAutoLayout()
        .setTitle(with: style.title)
        .setFont(with: .title3)
        .setColor(with: .label)
        .setIdentifier(with: section.identifier)
      
      return label
      
    case .description:
      guard let description = style.description else { break }
      let label = UILabel()
        .configAutoLayout()
        .setTitle(with: description)
        .setColor(with: .label)
        .setFont(with: .footnote)
        .setAlignment(to: .left)
        .setIdentifier(with: section.identifier)
      
      label.numberOfLines = 2

      return label
      
    case .timeline:
      guard let time = style.timeline else { break }
      let label = UILabel()
        .configAutoLayout()
        .setAlignment(to: .right)
        .setTitle(with: time)
        .setColor(with: .secondaryLabel)
        .setFont(with: .caption1)
        .setIdentifier(with: section.identifier)
      
      return label
      
    case .image:
      guard let image = style.image else { break }
      let imageView = UIImageView()
        .configAutoLayout()
        .setImage(with: image)
        .setIdentifier(with: section.identifier)
      imageView.contentMode = .scaleAspectFit
      
      return imageView
    }
    
    return nil
  }
  
  func makeToastView(with completion: (() -> Void)?) -> CLToastView {
    toastView.completion = completion
    CLToastViewSection.allCases.forEach {
      if let uiview = addComponents(in: $0) {
        toastView.addSubview(uiview)
        configDefaultLayout(of: uiview, in: $0)
      }
    }
    
    adjustLayouts()
    return toastView
  }
}

extension CLToastUIViewContainer {
  func configDefaultLayout(
    of view: UIView,
    in section: CLToastViewSection
  ) {
    switch section {
    case .title:
      view.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -16).isActive = true
      
    case .description:
      view.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -16).isActive = true
      
    case .timeline:
      NSLayoutConstraint.activate([
        view.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -12),
        view.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -16),
      ])
      
    case .image:
      NSLayoutConstraint.activate([
        view.widthAnchor.constraint(equalToConstant: style.imageSize.width),
        view.heightAnchor.constraint(equalToConstant: style.imageSize.height),
        view.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16),
        view.centerYAnchor.constraint(equalTo: toastView.centerYAnchor),
      ])
    }
  }
  
  func adjustLayouts() {
    configTitleLabelCenterYConstraints()
    configImageViewConstraints()
  }
  
  func configTitleLabelCenterYConstraints() {
    if
      let titleLabel = getComponent(in: .title),
      let descriptionLabel = getComponent(in: .description) {
      titleLabel.bottomAnchor.constraint(equalTo: toastView.centerYAnchor, constant: -4).isActive = true
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
      
    } else if let titleLabel = getComponent(in: .title) {
      titleLabel.centerYAnchor.constraint(equalTo: toastView.centerYAnchor).isActive = true
    }
  }
  
  func configImageViewConstraints() {
    if let imageView = getComponent(in: .image) {
      toastView.subviews.forEach {
        if $0.accessibilityIdentifier == CLToastViewSection.image.identifier { return }
        $0.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12).isActive = true
      }
    } else {
      toastView.subviews.forEach {
        $0.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 12).isActive = true
      }
    }
  }
  
  func getComponent(in section: CLToastViewSection) -> UIView? {
    toastView.subviews.first(
      where: { $0.accessibilityIdentifier == section.identifier }
    )
  }
}
