//
//  CLToastAnimatable.swift
//
//
//  Created by Celan on 2/4/24.
//

import UIKit

// MARK: Animate
// Toast Message의 Animation을 설정하는 델리게이트
// 외부에 노출해도 괜찮다. animate만 맞춰주면 오케이
// 아마 UIView가 채택하는 구조가 될 것
public protocol CLToastAnimatable {
  func appearingAnimate(for toastView: UIView, didAppear: @escaping (Bool) -> Void)
  func disappearingAnimate(for toastView: UIView, didDisappear: @escaping (Bool) -> Void)
  func animate(for view: UIView, completion: @escaping (Bool) -> Void)
}

public struct CLToastAnimateClient: CLToastAnimatable {
  /// 애니메이션을 시동합니다.
  /// - Parameters:
  ///   - view: 애니메이션을 동작할 Toast Message View를 전달합니다.
  ///   - completion: 애니메이션이 완전히 종료된 후 호출할 메소드를 전달합니다.
  public func animate(for view: UIView, completion: @escaping (Bool) -> Void) {
    appearingAnimate(for: view) { isAniamted in
      disappearingAnimate(for: view) { isAnimated in
        completion(isAniamted)
      }
    }
  }
  
  public func appearingAnimate(
    for toastView: UIView,
    didAppear: @escaping (Bool) -> Void
  ) {
    UIView.animate(
      withDuration: 0.35,
      delay: 0.0,
      options: .curveEaseOut
    ) {
      toastView.frame.origin.y += 40
      toastView.layer.opacity = 1.0
      
    } completion: { isAnimated in
      didAppear(isAnimated)
    }
  }
  
  public func disappearingAnimate(
    for toastView: UIView,
    didDisappear: @escaping (Bool) -> Void
  ) {
    UIView.animate(
      withDuration: 0.35,
      delay: 0.35 + 1.0,
      options: .curveEaseOut
    ) {
      toastView.frame.origin.y -= 40
      toastView.layer.opacity = 0.0
      
    } completion: { isAnimated in
      didDisappear(isAnimated)
    }
  }
}
