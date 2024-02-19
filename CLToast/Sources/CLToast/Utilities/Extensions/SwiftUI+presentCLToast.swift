//
//  SwiftUI+presentCLToast.swift
//
//
//  Created by Celan on 2/12/24.
//

import SwiftUI

public extension View {
  /**
   overlay a ToastView with given parameters.
   
   - Parameters:
    - isPresented: Bind a ``Bool`` type value to present toastView. You don't have to mutate this value with ``withAnimation`` since the library internally handles transition/animation with ``CLToastStyle`` value.
    - style: ``CLToastStyle`` which configures toastView's properties like title, description, timeline and radius etc.
    - section: A value which decides toastView's display section. Default value is ``.top``.
    - completion: Closure that is called inside ``onDisappear`` closure. You can skip ``completion`` when you don't have to call any callbacks.
   */
  func presentToast(
    isPresented: Binding<Bool>,
    with style: CLToastStyle,
    section: CLToastDisplaySection = .top,
    onDismiss: (() -> Void)? = nil
  ) -> some View {
    var style = style
    style.section = section
    
    return modifier(
      CLToastViewModifier(
        isPresented: isPresented,
        style: style,
        onDismiss: onDismiss
      )
    )
  }

  /**
   overlay a ToastView with given parameters.
   
   - Parameters:
    - isPresented: Bind a ``Bool`` type value to present toastView. You don't have to mutate this value with ``withAnimation`` since the library internally handles transition/animation with ``CLToastStyle`` value.
    - title: toastView's title.
    - height: toastView's height. Default value is ``100``.
    - completion: Closure that is called inside ``onDisappear`` closure. You can skip ``completion`` when you don't have to call any callbacks.
   */
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
  
  /**
  overlay a ToastView with given parameters.
  
  - Parameters:
   - isPresented: Bind a ``Bool`` type value to present toastView. You don't have to mutate this value with ``withAnimation`` since the library internally handles transition/animation with ``CLToastStyle`` value.
   - style: ``CLToastStyle`` which configures toastView's properties like title, description, timeline and radius etc.
   - transition: Transition configuring struct/class which conforms ``CLToastSwiftUIAnimation``.
   - section: A value which decides toastView's display section. Default value is ``.top``.
   - completion: Closure that is called inside ``onDisappear`` closure. You can skip ``completion`` when you don't have to call any callbacks.
   
   If you want to use your own animation, you should manage toastView's animations conforming ``CLToastSwiftUIAnimation`` which asks you to implement ``makeInsertionTransition()`` and ``makeRemovalTransition()``.
   ``CLToast`` configures your transition flow to animate toastView smoothly.
   Removal transition would be triggered after delay which is set by ``CLToastAnimations`` value, ``displayTime``.
  */
  func presentToast(
    isPresented: Binding<Bool>,
    with style: CLToastStyle,
    transition: any CLToastSwiftUITransition,
    section: CLToastDisplaySection = .top,
    onDismiss: (() -> Void)? = nil
  ) -> some View {
    var style = style
    style.section = section
    
    return modifier(
      CLToastViewModifier(
        isPresented: isPresented,
        style: style,
        transition: transition,
        onDismiss: onDismiss
      )
    )
  }
}
