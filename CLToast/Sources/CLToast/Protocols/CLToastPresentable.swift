//
//  View.Layer.swift
//
//
//  Created by Celan on 1/22/24.
//

import UIKit

protocol ViewLayerConfigurable {
  func configAnimation()
  func configDropShadow()
  func configVerticalLayout()
}

protocol CLToastPresentable: UIViewController {
  var onDismiss: (() -> Void)? { get set }
}
