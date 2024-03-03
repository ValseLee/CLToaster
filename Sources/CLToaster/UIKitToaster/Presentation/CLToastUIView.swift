//
//  CLToastUIView.swift
//
//
//  Created by Celan on 3/2/24.
//

import UIKit

protocol CLToastViewDelegate: UIView {
  func makeView(with style: CLToastStyle)
}

class CLToastTitleLabel: UILabel {
  func config(with title: String) {
    self
      .configAutoLayout()
      .setTitle(with: title)
      .setFont(with: .title2)
      .setColor(with: .label)
      .setIdentifier(with: title)
  }
}

class CLToastDescriptionLabel: UILabel {
  func config(with description: String) {
    self
      .configAutoLayout()
      .setTitle(with: description)
      .setColor(with: .label)
      .setFont(with: .footnote)
      .setAlignment(to: .left)
      .setIdentifier(with: description)
    
    numberOfLines = 2
  }
}

class CLToastTimelineLabel: UILabel {
  func config(with timeline: String) {
    self
      .configAutoLayout()
      .setAlignment(to: .right)
      .setTitle(with: timeline)
      .setColor(with: .secondaryLabel)
      .setFont(with: .caption1)
  }
}

class CLToastImageView: UIImageView {
  func config(with image: UIImage) {
    self
      .configAutoLayout()
      .setImage(with: image)
      .setIdentifier(with: image.description)
    contentMode = .scaleAspectFit
  }
}

class CLToastView: UIView, CLToastViewDelegate {
  var titleLabel = CLToastTitleLabel()
  var descriptionLabel = CLToastDescriptionLabel()
  var timelineLabel = CLToastTimelineLabel()
  var imageView = CLToastImageView()
  
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
  
  func makeView(with style: CLToastStyle) {
    layer.opacity = 0.1
    layer.cornerRadius = style.layerCornerRadius
    backgroundColor = style.backgroundColor
    
    makeTitleLabel(with: style.title)
    
    if let description = style.description {
      makeDescriptionLabel(with: description)
    } else {
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    if let timeline = style.timeline {
      makeTimelineLabel(with: timeline)
    }
    
    if let image = style.image {
      makeImageView(with: image, by: style)
      
      titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12).isActive = true
      if let descriptionSubview = subviews.first(where: { $0.accessibilityIdentifier == style.description }) {
        descriptionSubview.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12).isActive = true
      }
      
      if let timelineSubview = subviews.first(where: { $0.accessibilityIdentifier == style.timeline }) {
        timelineSubview.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12).isActive = true
      }
      
    } else {
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
      if let descriptionSubview = subviews.first(where: { $0.accessibilityIdentifier == style.description }) {
        descriptionSubview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
      }
      
      if let timelineSubview = subviews.first(where: { $0.accessibilityIdentifier == style.timeline }) {
        timelineSubview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
      }
    }
  }
}

extension CLToastView {
  func makeTitleLabel(with title: String) {
    titleLabel.config(with: title)
    addSubview(titleLabel)
    titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
  }
  
  func makeDescriptionLabel(with description: String) {
    descriptionLabel.config(with: description)
    addSubview(descriptionLabel)
    descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true
    descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
  }
  
  func makeTimelineLabel(with timeline: String) {
    timelineLabel.config(with: timeline)
    addSubview(timelineLabel)
    NSLayoutConstraint.activate([
      timelineLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
      timelineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
    ])
  }
  
  func makeImageView(with image: UIImage, by style: CLToastStyle) {
    imageView.config(with: image)
    addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalToConstant: style.imageSize.width),
      imageView.heightAnchor.constraint(equalToConstant: style.imageSize.height),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
}
