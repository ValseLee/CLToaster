//
//  CLToastPresentable.swift
//
//
//  Created by Celan on 1/22/24.
//

import UIKit

// MARK: Presenter
// Toast Message를 present할 수 있는 델리게이트
// CLToast의 present로 트리거되는 메소드를 갖는다.
// Animation 설정에 따라 Toast를 present한다.
public protocol CLToastPresentable: AnyObject, UIViewController {
  var animationDelegate: (CLToastAnimatable)? { get set }
  var toastView: UIView { get set }
  var onDismiss: (() -> Void)? { get }
}
