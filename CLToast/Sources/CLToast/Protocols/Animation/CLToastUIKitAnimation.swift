//
//  CLToastUIKitAnimation.swift
//
//
//  Created by Celan on 2/19/24.
//

import UIKit

public protocol CLToastUIKitAnimation: CLToastAnimation {
  func makeAppearingAnimation(toastView: UIView, for style: CLToastStyle)
  func makeDisappearingAnimation(toastView: UIView, for style: CLToastStyle)
}
