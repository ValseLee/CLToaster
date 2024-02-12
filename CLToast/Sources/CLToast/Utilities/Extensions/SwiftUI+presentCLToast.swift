//
//  SwiftUI+presentCLToast.swift
//
//
//  Created by Celan on 2/12/24.
//

import SwiftUI

public extension View {
  @ViewBuilder
  func presentToast(
    isPresented: Binding<Bool>,
    with style: CLToastStyle,
    onDismiss: (() -> Void)? = nil
  ) -> some View {
    modifier(
      CLToastViewModifier(
        isPresented: isPresented,
        style: style,
        onDismiss: onDismiss
      )
    )
  }
}
