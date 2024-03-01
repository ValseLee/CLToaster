//
//  CLToastUIKitTapGesture.swift
//
//
//  Created by Celan on 2/28/24.
//

import UIKit

public protocol CLToastUIKitTapGesture {
  func makeTapGesture(for toastView: UIView, action: (() -> Void)?)
}

struct CLToastUIKitGestureManager: CLToastUIKitTapGesture {
  func makeTapGesture(for toastView: UIView, action: (() -> Void)?) {
    toastView.addTapGestureRecognizer {
      guard let action else { return }
      action()
    }
  }
}

extension UIView {
  fileprivate struct AssociatedObjectKeys {
    static var UIKIT_CLTOASTER = "UIKIT_CLTOASTER_TAP_GESTURE_KEY"
  }
  
  fileprivate typealias Action = (() -> Void)?
  
  fileprivate var tapGestureRecognizerAction: Action? {
    get {
      let tapGestureRecognizerActionInstance = objc_getAssociatedObject(
        self,
        &AssociatedObjectKeys.UIKIT_CLTOASTER
      ) as? Action
      return tapGestureRecognizerActionInstance
    }
    set {
      if let newValue = newValue {
        objc_setAssociatedObject(
          self,
          &AssociatedObjectKeys.UIKIT_CLTOASTER,
          newValue,
          objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
        )
      }
    }
  }
  
  public func addTapGestureRecognizer(action: (() -> Void)?) {
    self.isUserInteractionEnabled = true
    self.tapGestureRecognizerAction = action
    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(handleTapGesture)
    )
    self.addGestureRecognizer(tapGestureRecognizer)
  }
  
  @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
    if let action = self.tapGestureRecognizerAction {
      action?()
    } else {
      print("no action")
    }
  }
}
