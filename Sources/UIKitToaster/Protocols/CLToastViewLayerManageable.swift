//
//  CLToastViewLayerManageable.swift
//
//
//  Created by Celan on 2/9/24.
//

import Common
import UIKit

protocol CLToastViewLayerManageable {
  func configLayer(for view: UIView, with style: CLToastStyle)
}

struct CLToastViewLayerClient: CLToastViewLayerManageable {
  func configLayer(for view: UIView, with style: CLToastStyle) {
    view.layer.opacity = 0.1
    view.layer.cornerRadius = style.layerCornerRadius
    view.backgroundColor = style.backgroundColor
  }
}
