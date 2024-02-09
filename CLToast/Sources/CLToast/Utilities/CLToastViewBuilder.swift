//
//  CLToastViewBuilder.swift
//
//
//  Created by Celan on 2/5/24.
//

import UIKit

enum CLViewBuildError: Error {
  case noTitleLabel
  case duplicateComponents
}

public struct CLToastViewBuilder {
  internal var toastView: UIView = UIView()
  
  public func buildComponents(
    in section: CLDefaultToastViewSection,
    color: UIColor? = nil
  ) throws -> Self {
    guard getSubview(for: section.identifier) == nil else {
      throw CLViewBuildError.duplicateComponents
    }
    
    switch section {
    case .title(let title):
      let label = UILabel()
        .configAutoLayout()
        .setTitle(with: title)
        .setFont(with: .title3)
        .setColor(with: color ?? .label)
        .setIdentifier(with: section.identifier)
      
      toastView.addSubview(label)
      configDefaultLayout(view: label, in: section)
      
    case .description(let description):
      let label = UILabel()
        .configAutoLayout()
        .setTitle(with: description)
        .setColor(with: color ?? .label)
        .setFont(with: .body)
        .setAlignment(to: .left)
        .setIdentifier(with: section.identifier)
      
      toastView.addSubview(label)
      configDefaultLayout(view: label, in: section)
      
    case .timeline(let time):
      let label = UILabel()
        .configAutoLayout()
        .setAlignment(to: .right)
        .setTitle(with: time)
        .setColor(with: color ?? .secondaryLabel)
        .setFont(with: .caption1)
        .setIdentifier(with: section.identifier)
      
      toastView.addSubview(label)
      configDefaultLayout(view: label, in: section)
      
    case .image(let image, _):
      let imageView = UIImageView()
        .configAutoLayout()
        .setImage(with: image)
        .setIdentifier(with: section.identifier)
      imageView.contentMode = .scaleAspectFit
      
      toastView.addSubview(imageView)
      configDefaultLayout(view: imageView, in: section)
    }
    
    return self
  }
  
  public func buildToastView() throws -> UIView? {
    guard let titleLabel = getSubview(for: "TITLE") else {
      throw CLViewBuildError.noTitleLabel
    }
    if let descriptionView = getSubview(for: "DESCRIPTION") {
      descriptionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
    }
    
    adjustLayouts()
    return toastView
  }
}

extension CLToastViewBuilder {
  func configDefaultLayout(
    view: UIView,
    in section: CLDefaultToastViewSection
  ) {
    switch section {
    case .title(_):
      NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 20),
        view.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -20),
      ])
      
    case .description(_):
      NSLayoutConstraint.activate([
        view.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -20),
      ])
      
    case .timeline(_):
      NSLayoutConstraint.activate([
        view.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -16),
        view.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -20),
      ])
      
    case .image(_, let size):
      NSLayoutConstraint.activate([
        view.widthAnchor.constraint(equalToConstant: size.width),
        view.heightAnchor.constraint(equalToConstant: size.height),
        view.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16),
        view.centerYAnchor.constraint(equalTo: toastView.centerYAnchor),
      ])
    }
  }
  
  func adjustLayouts() {
    if let imageView = getSubview(for: "IMAGE") {
      toastView.subviews.forEach {
        if $0.accessibilityIdentifier == "IMAGE" { return }
        $0.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
      }
    } else {
      toastView.subviews.forEach {
        $0.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16).isActive = true
      }
    }
  }
  
  func getSubview(for id: String) -> UIView? {
    toastView.subviews.first(
      where: { $0.accessibilityIdentifier == id }
    )
  }
}
