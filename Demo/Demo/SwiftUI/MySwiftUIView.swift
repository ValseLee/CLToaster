//
//  MySwiftUIView.swift
//  Demo
//
//  Created by Celan on 2/12/24.
//

import CLToast
import SwiftUI

struct MySwiftUIView: View {
  var body: some View {
    NavigationStack {
      MyView()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("🚀 CLToast 🚀")
    }
  }
}

struct MyView: View {
  let style = CLToastStyleBuilder("Hi")
    .buildValue(\.description, into: "HIHI")
    .buildValue(\.timeline, into: Date().formatted())
    .buildValue(\.image, into: UIImage(systemName: "hare.fill"))
    .buildStyle()
  
  let animation = CLToastAnimationBuilder()
    .buildValue(\.displayTime, into: 3.0)
    .buildAnimation()
  
  @State private var isDefaultToastPresented = false
  @State private var isDetailedToastPresented = false
  @State private var isCustomAnimationToastPresented = false
  @State private var isBottomToastPresented = false
  
  var body: some View {
    VStack(spacing: 20) {
      Button {
        isDefaultToastPresented = true
      } label: {
        Text("default")
      }
      
      Button {
        isDetailedToastPresented = true
      } label: {
        Text("detailed")
      }
      
      Button {
        isCustomAnimationToastPresented = true
      } label: {
        Text("custom animation")
      }
      
      Button {
        isBottomToastPresented = true
      } label: {
        Text("bottom toast")
      }
    }
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity
    )
    .presentToast(
      isPresented: $isDefaultToastPresented,
      with: "title",
      height: 100
    )
    .presentToast(
      isPresented: $isDetailedToastPresented,
      with: style
    ) {
      print("Dismissed")
    }
    .presentToast(
      isPresented: $isCustomAnimationToastPresented,
      with: style,
      transition: ToastTransition(toastAnimations: animation)
    )
    .presentToast(
      isPresented: $isBottomToastPresented,
      with: style,
      section: .bottom
    )
  }
}

struct ToastTransition: CLToastSwiftUITransition {
  var toastAnimations: CLToastAnimations
  
  func makeAnimation() -> Animation {
    Animation
      .bouncy(duration: toastAnimations.animationSpeed)
  }
  
  func makeInsertionTransition(for style: CLToastStyle) -> AnyTransition {
    AnyTransition
      .offset(x: -40)
      .combined(with: .opacity)
  }
  
  func makeRemovalTransition(for style: CLToastStyle) -> AnyTransition {
    AnyTransition
      .offset(x: 40)
      .combined(with: .opacity)
  }
}

#Preview {
  MySwiftUIView()
}
