//
//  SwiftUI+presentCLToast.swift
//
//
//  Created by Celan on 2/12/24.
//

import SwiftUI

public extension View {
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

  func presentToast(
    isPresented: Binding<Bool>,
    with title: String,
    height: CGFloat,
    onDismiss: (() -> Void)? = nil
  ) -> some View {
    let style = CLToastStyleBuilder(title)
      .buildValue(\.height, into: height)
      .buildStyle()
    
    return modifier(
      CLToastViewModifier(
        isPresented: isPresented,
        style: style,
        onDismiss: onDismiss
      )
    )
  }
  
  func presentToast(
    isPresented: Binding<Bool>,
    with style: CLToastStyle,
    animate: any CLToastSwiftUIAnimation,
    onDismiss: (() -> Void)? = nil
  ) -> some View {
    return modifier(
      CLToastViewModifier(
        isPresented: isPresented,
        style: style,
        animation: animate,
        onDismiss: onDismiss
      )
    )
  }
}
