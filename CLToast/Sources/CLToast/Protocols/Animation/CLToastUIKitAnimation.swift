//
//  CLToastUIKitAnimation.swift
//
//
//  Created by Celan on 2/19/24.
//

import UIKit

public protocol CLToastUIKitAnimation: CLToastAnimation {
  func appearing(toastView: UIView)
  func disappearing(toastView: UIView)
}
