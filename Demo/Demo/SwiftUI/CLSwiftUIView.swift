//
//  CLSwiftUIView.swift
//  Demo
//
//  Created by Celan on 2/12/24.
//

import CLToaster
import SwiftUI

struct CLSwiftUIView: View {
  let style = CLToastStyleBuilder("Title")
    .assign(\.description, into: "Description")
    .assign(\.timeline, into: Date().formatted())
    .assign(\.image, into: UIImage(named: "Logo"))
    .assign(\.height, into: 150)
    .build()
  
  let animation = CLToastAnimationBuilder()
    .assign(\.displayTime, into: 1.5)
    .build()
  
  @State private var isDefaultToastPresented = false
  @State private var isDetailedToastPresented = false
  @State private var isCustomAnimationToastPresented = false
  @State private var isTopToastPresented = false
  
  var body: some View {
    VStack(spacing: 20) {
      Button {
        isDefaultToastPresented = true
      } label: {
        Text("Quick Toast")
      }
      
      Button {
        isDetailedToastPresented = true
      } label: {
        Text("Detail Toast")
      }
      
      Button {
        isCustomAnimationToastPresented = true
      } label: {
        Text("Animation Custom")
      }
      
      Button {
        isTopToastPresented = true
      } label: {
        Text("Top Toast")
      }
    }
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity
    )
    .presentToast(
      isPresented: $isDefaultToastPresented,
      with: "Title",
      height: 100
    )
    .presentToast(
      isPresented: $isDetailedToastPresented,
      with: style
    ) {
      onToastDisappeared()
    }
    .presentToast(
      isPresented: $isCustomAnimationToastPresented,
      with: style,
      transition: ToastTransition(toastAnimations: animation)
    )
    .presentToast(
      isPresented: $isTopToastPresented,
      with: style,
      section: .top
    )
  }
  
  func onToastDisappeared() {
    print(#function)
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
  CLSwiftUIView()
}
