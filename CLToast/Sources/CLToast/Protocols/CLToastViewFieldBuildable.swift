//
//  CLToastViewBuildable.swift
//  
//
//  Created by Celan on 2/6/24.
//

import UIKit

protocol CLToastViewFieldBuildable {
  associatedtype CLToastViewType: CLToastViewField
  var toastView: CLToastViewType { get set }
  
  init(of toastView: CLToastViewType)
  
  @MainActor
  mutating func makeLabel(
    for path: WritableKeyPath<CLToastViewType, UILabel?>,
    config makeView: @escaping @MainActor () -> UILabel?
  )
  
  @MainActor
  mutating func makeImageView(
    for path: WritableKeyPath<CLToastViewType, UIImageView?>,
    config makeView: @escaping @MainActor () -> UIImageView?
  )
}

