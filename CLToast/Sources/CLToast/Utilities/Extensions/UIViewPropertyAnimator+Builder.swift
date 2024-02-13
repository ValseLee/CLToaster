//
//  File.swift
//  
//
//  Created by Celan on 2/13/24.
//

import UIKit

public extension UIViewPropertyAnimator {
  @discardableResult
  func buildAnimation(animation: @escaping () -> Void) -> Self {
    self.addAnimations(animation)
    return self
  }
}
