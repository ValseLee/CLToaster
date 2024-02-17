//
//  MySwiftUIView.swift
//  Demo
//
//  Created by Celan on 2/12/24.
//

import CLToast
import SwiftUI

struct MySwiftUIView: View {
  let style = CLToastStyleBuilder("Hi")
    .buildValue(\.description, into: "HIHI")
    .buildValue(\.timeline, into: "Yes")
    .buildStyle()
  
  let animation = CLToastAnimationBuilder()
    .buildValue(\.offsetY, into: 50)
    .buildValue(\.displayTime, into: 3.0)
    .buildValue(\.animateFrom, into: .bottom)
    .buildAnimation()
  
  @State private var isDefaultToastPresented = false
  @State private var isCustomAnimationToastPresented = false
  @State private var randomColor = [
    Color.red,
    Color.yellow,
    Color.orange
  ]
  
  var body: some View {
    ScrollView {
      Button {
        isDefaultToastPresented = true
      } label: {
        Text("default")
      }
      
      Button {
        isCustomAnimationToastPresented = true
      } label: {
        Text("animation")
      }
    }
    .frame(maxWidth: .infinity)
    .background { randomColor.randomElement()! }
    .presentToast(
      isPresented: $isDefaultToastPresented,
      with: style
    ) {
      print("Dismissed")
    }
    .presentToast(
      isPresented: $isCustomAnimationToastPresented,
      with: style,
      animate: ToastAnimation(toastAnimations: animation)
    )
  }
}

struct ToastAnimation: CLToastSwiftUIAnimation {
  var toastAnimations: CLToastAnimations
  
  func makeAnimation() -> Animation {
    Animation
      .easeInOut(duration: toastAnimations.animationSpeed)
  }
  
  func makeTransition() -> AnyTransition {
    AnyTransition
      .offset(y: toastAnimations.offsetY)
      .combined(with: .opacity)
  }
}

#Preview {
  NavigationStack {
    MySwiftUIView()
      .navigationTitle("Hi")
  }
}
