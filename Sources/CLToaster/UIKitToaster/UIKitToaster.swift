//
//  UIKitToaster.swift
//
//
//  Created by Celan on 3/1/24.
//

import UIKit

public struct CLToastUIKitData {
  var style: CLToastStyle
  var animation: any CLToastUIKitAnimation
  var display: CLToastDisplaySection = .bottom
  var completion: (() -> Void)?
  
  public init(
    style: CLToastStyle,
    animation: any CLToastUIKitAnimation = CLToastUIKitAnimationClient(toastAnimations: CLToastAnimations()),
    display: CLToastDisplaySection,
    completion: ( () -> Void)? = nil
  ) {
    self.style = style
    self.animation = animation
    self.display = display
    self.completion = completion
  }
}


public struct UIKitToaster {
  private let data: CLToastUIKitData
  
  private let layerClient = CLToastViewLayerClient()
  private let gestureManager: any CLToastUIKitTapGesture = CLToastUIKitGestureManager()
  private let viewContainer: CLToastUIViewContainer
  
  public init(data: CLToastUIKitData) {
    self.data = data
    self.viewContainer = CLToastUIViewContainer(style: data.style)
  }
}

public extension UIKitToaster {
  /**
   Present a ToastView over UIView with given style.
   Its layout and components are determined by user configured style which is injected when ``CLToast`` has been initialized.
   - Parameter view: Parent view. ToastView will become a subview of this.
   */
  func present(in view: UIView) {
    let toastView = viewContainer.makeToastView(with: data.completion)
    
    layerClient.configLayer(for: toastView, with: data.style)
    if data.animation.toastAnimations.isAnimationEnabled {
      animate(toastView)
      addSubview(toastView, for: view)
    } else {
      Task {
        await present(in: view, toastView: toastView)
      }
    }
  }
}

// MARK: - UIKit
extension UIKitToaster {
  /**
   Present a ToastView with default ToastView built by given style.
   This method is being called when the style is not animatable.
   - Parameters:
      - view: Parent view. ToastView will become a subview of this.
      - toastView: ToastView which is displayed for ``displayTimeInterval`` long.
   */
  @MainActor
  private func present(in view: UIView, toastView: CLToastView) async {
    gestureManager.makeTapGesture(for: toastView) {
      toastView.removeFromSuperview()
    }
    
    toastView.layer.opacity = 1.0
    addSubview(toastView, for: view)
    try? await Task.sleep(nanoseconds: UInt64(data.animation.toastAnimations.displayTime * 1_000_000_000))
    toastView.removeFromSuperview()
  }
  
  func addSubview(_ toastView: UIView, for view: UIView) {
    view.addSubview(toastView)
    configAutoLayout(of: toastView, in: view)
  }
  
  func configAutoLayout(of toastView: UIView, in view: UIView) {
    let style = data.style
    toastView.translatesAutoresizingMaskIntoConstraints = false
    
    switch style.section {
    case .top:
      toastView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: style.verticalPadding).isActive = true
    case .bottom:
      toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -style.verticalPadding).isActive = true
    case .center:
      toastView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: style.horizontalPadding),
      toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -style.horizontalPadding),
      toastView.heightAnchor.constraint(equalToConstant: style.height)
    ])
  }
  
  // TODO: - Animator
  func animate(_ toastView: UIView) {
    let animatior = data.animation
    let style = data.style
    
    if
      let appearingAnimation = animatior.makeAnimation() as? UIViewPropertyAnimator,
      let disappearingAnimation = animatior.makeAnimation() as? UIViewPropertyAnimator {
      let displayTime = DispatchTime.now()
      + animatior.toastAnimations.displayTime
      + animatior.toastAnimations.animationSpeed
      
      toastView.isUserInteractionEnabled = true
      
      gestureManager.makeTapGesture(for: toastView) {
        appearingAnimation.stopAnimation(false)
        disappearingAnimation.startAnimation()
      }
      
      appearingAnimation
        .addAnimations {
          animatior.makeAppearingAnimation(toastView: toastView, for: style)
        }
      
      disappearingAnimation
        .addAnimations {
          animatior.makeDisappearingAnimation(toastView: toastView, for: style)
        }
      
      disappearingAnimation
        .addCompletion { state in
          if case .end = state { toastView.removeFromSuperview() }
        }
      
      appearingAnimation.startAnimation()
      
      DispatchQueue.main.asyncAfter(deadline: displayTime) {
        disappearingAnimation.startAnimation()
      }
    }
  }
}

