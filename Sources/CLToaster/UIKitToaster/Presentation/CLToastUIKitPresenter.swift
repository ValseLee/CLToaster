//
//  CLToastUIKitPresenter.swift
//
//
//  Created by Celan on 3/1/24.
//

import UIKit

protocol UIKitToastPresenter {
  var service: UIKitToastService { get }
  var animator: UIKitToastAnimator { get }
  var toastView: CLToastViewDelegate { get }
  
  func present(in view: UIView)
}

struct CLToastUIKitPresenter: UIKitToastPresenter {
  var service: UIKitToastService
  var animator: UIKitToastAnimator
  var toastView: CLToastViewDelegate
  var gesture: any CLToastUIKitTapGesture
  
  init(service: UIKitToastService, toastView: CLToastViewDelegate) {
    self.service = service
    self.toastView = toastView
    
    self.gesture = CLToastUIKitGestureManager()
    self.animator = CLToastUIKitAnimator(animation: service.getAnimation(), gesture: gesture)
  }
  
  func present(in view: UIView) {
    let style = service.getStyle()
    let animation = service.getAnimation()
    toastView.makeView(with: style)
    
    if animation.toastAnimations.isAnimationEnabled {
      animator.animate(toastView, with: style)
      addSubview(toastView, in: view)
      
    } else {
      Task { await present(in: view, toastView: toastView) }
      addSubview(toastView, in: view)
    }
  }
  
  @MainActor
  private func present(in view: UIView, toastView: UIView) async {
    gesture.makeTapGesture(for: toastView) {
      toastView.removeFromSuperview()
    }
    
    toastView.layer.opacity = 1.0
    addSubview(toastView, in: view)
    try? await Task.sleep(nanoseconds: UInt64(service.getAnimation().toastAnimations.displayTime * 1_000_000_000))
    toastView.removeFromSuperview()
  }
 
  func addSubview(_ toastView: UIView, in view: UIView) {
    view.addSubview(toastView)
    configAutoLayout(in: view)
  }
  
  func configAutoLayout(in view: UIView) {
    let style = service.getStyle()
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
}
