//
//  CLToastSwiftUITransition.swift
//
//
//  Created by Celan on 2/19/24.
//

import SwiftUI

public protocol CLToastSwiftUITransition: CLToastAnimation {
  func makeInsertionTransition(for style: CLToastStyle) -> AnyTransition
  func makeRemovalTransition(for style: CLToastStyle) -> AnyTransition
}
