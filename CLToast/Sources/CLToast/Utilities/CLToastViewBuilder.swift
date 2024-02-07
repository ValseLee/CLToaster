//
//  CLToastViewBuilder.swift
//
//
//  Created by Celan on 2/5/24.
//

import UIKit

struct CLToastViewBuilder<T: CLToastViewField>: CLToastViewFieldBuildable {
  typealias CLToastViewType = T
  var toastView: CLToastViewType
  
  init(of toastView: T) {
    self.toastView = toastView
  }
  
  @MainActor
  // TODO: - throw로 makeView가 안 되었을 때를 분기 처리
  mutating func makeLabel(
    for path: WritableKeyPath<CLToastViewType, UILabel?>,
    config makeView: @escaping @MainActor () -> UILabel?
  ) {
    guard let label = makeView() else { return }
    label.translatesAutoresizingMaskIntoConstraints = false
    toastView[keyPath: path] = label
  }
  
  @MainActor
  mutating func makeImageView(
    for path: WritableKeyPath<CLToastViewType, UIImageView?>,
    config makeView: @escaping @MainActor () -> UIImageView?
  ) {
    guard let imageView = makeView() else { return }
    imageView.translatesAutoresizingMaskIntoConstraints = false
    toastView[keyPath: path] = imageView
  }
}
