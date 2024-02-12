//
//  CLToastViewBuilder.swift
//
//
//  Created by Celan on 2/5/24.
//

import UIKit
import SwiftUI

/// ToastView를 Build하는 빌더의 추상화 프로토콜
/// UIKit, SwiftUI에 대응할 수 있도록 추상화 타입을 리턴하도록 한다.
public protocol CLToastViewBuildDelegate {
  associatedtype ToastView
  func buildToastView() -> ToastView?
}

struct CLToastViewBuilder: CLToastViewBuildDelegate {
  var style: CLToastStyle
  var toastView: UIView = UIView()
  
  func buildComponents(
    in section: CLToastViewSection,
    color: UIColor? = nil
  ) {
    switch section {
    case .title:
      let label = UILabel()
        .configAutoLayout()
        .setTitle(with: style.title)
        .setFont(with: .title3)
        .setColor(with: color ?? .label)
        .setIdentifier(with: section.identifier)
      
      toastView.addSubview(label)
      configDefaultLayout(view: label, in: section)
      
    case .description:
      guard let description = style.description else { break }
      let label = UILabel()
        .configAutoLayout()
        .setTitle(with: description)
        .setColor(with: color ?? .label)
        .setFont(with: .footnote)
        .setAlignment(to: .left)
        .setIdentifier(with: section.identifier)
      
      toastView.addSubview(label)
      configDefaultLayout(view: label, in: section)
      
    case .timeline:
      guard let time = style.timeline else { break }
      let label = UILabel()
        .configAutoLayout()
        .setAlignment(to: .right)
        .setTitle(with: time)
        .setColor(with: color ?? .secondaryLabel)
        .setFont(with: .caption1)
        .setIdentifier(with: section.identifier)
      
      toastView.addSubview(label)
      configDefaultLayout(view: label, in: section)
      
    case .image:
      guard let image = style.image else { break }
      let imageView = UIImageView()
        .configAutoLayout()
        .setImage(with: image)
        .setIdentifier(with: section.identifier)
      imageView.contentMode = .scaleAspectFit
      
      toastView.addSubview(imageView)
      configDefaultLayout(view: imageView, in: section)
    }
  }
  
  func buildToastView() -> UIView? {
    buildComponents(in: .title)
    if let description = style.description { buildComponents(in: .description ) }
    if let timeline = style.timeline { buildComponents(in: .timeline) }
    if let image = style.image { buildComponents(in: .image) }
   
    adjustLayouts()
    return toastView
  }
}

extension CLToastViewBuilder {
  func configDefaultLayout(
    view: UIView,
    in section: CLToastViewSection
  ) {
    switch section {
    case .title:
      NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 12),
        view.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -16),
      ])
      
    case .description:
      view.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -16).isActive = true
      if let titleLabel = getComponent(in: .title) {
        view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
      }
      
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
