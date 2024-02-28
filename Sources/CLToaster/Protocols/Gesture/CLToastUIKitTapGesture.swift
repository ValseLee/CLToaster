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
  
  // Set our computed property type to a closure
  fileprivate var tapGestureRecognizerAction: Action? {
    set {
      if let newValue = newValue {
        // Computed properties get stored as associated objects
        objc_setAssociatedObject(
          self,
          &AssociatedObjectKeys.UIKIT_CLTOASTER,
          newValue,
          objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
      }
    }
    get {
      let tapGestureRecognizerActionInstance = objc_getAssociatedObject(
        self,
        &AssociatedObjectKeys.UIKIT_CLTOASTER
      ) as? Action
      return tapGestureRecognizerActionInstance
    }
  }
  
  // This is the meat of the sauce, here we create the tap gesture recognizer and
  // store the closure the user passed to us in the associated object we declared above
  public func addTapGestureRecognizer(action: (() -> Void)?) {
    self.isUserInteractionEnabled = true
    self.tapGestureRecognizerAction = action
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
    self.addGestureRecognizer(tapGestureRecognizer)
  }
  
  // Every time the user taps on the UIImageView, this function gets called,
  // which triggers the closure we stored
  @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
    if let action = self.tapGestureRecognizerAction {
      action?()
    } else {
      print("no action")
    }
  }
}
