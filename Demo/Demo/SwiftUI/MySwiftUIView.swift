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
  
  @State private var isDefaultToastPresented = false
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
    }
    .frame(maxWidth: .infinity)
    .background { randomColor.randomElement()! }
    .presentToast(
      isPresented: $isDefaultToastPresented,
      with: style
    ) {
      print("Dismissed")
    }
  }
}

#Preview {
  NavigationStack {
    MySwiftUIView()
      .navigationTitle("Hi")
  }
}
