//
//  CLToastViewBuildable.swift
//
//
//  Created by Celan on 2/13/24.
//

import Foundation

public protocol CLToastViewBuildable {
  associatedtype ToastView
  func buildToastView() -> ToastView?
}
