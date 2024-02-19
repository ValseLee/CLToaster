//
//  CLToastViewModifier.swift
//
//
//  Created by Celan on 2/12/24.
//

import SwiftUI

struct CLToastViewModifier: ViewModifier {
  @Binding var isPresented: Bool
  @State private var isPresenting: Bool = false
  
  let transitionManager: any CLToastSwiftUITransition
  let onDismiss: (() -> Void)?
  let style: CLToastStyle
  
  var alignment: Alignment {
    switch style.section {
    case .top: .top
    case .bottom: .bottom
    case .center: .center
    }
  }
  
  init(
    isPresented: Binding<Bool>,
    style: CLToastStyle,
    onDismiss: (() -> Void)? = nil
  ) {
    self.style = style
    let animation = CLToastAnimations()
    self.transitionManager = CLToastTransitionClient(toastAnimations: animation)
    self._isPresented = isPresented
    self.onDismiss = onDismiss
  }
  
  init(
    isPresented: Binding<Bool>,
    style: CLToastStyle,
    transition: any CLToastSwiftUITransition,
    onDismiss: (() -> Void)? = nil
  ) {
    self.style = style
    self.transitionManager = transition
    self._isPresented = isPresented
    self.onDismiss = onDismiss
  }
  
  func body(content: Content) -> some View {
    content
      .onChange(of: isPresented) { newValue in
        presentToast(for: newValue)
      }
      .overlay(alignment: alignment) {
        if isPresenting {
          CLToastModifiedView(
            style: style,
            onDismiss: onDismiss
          )
          .transition(
            .asymmetric(
              insertion: transitionManager.makeInsertionTransition(for: style),
              removal: transitionManager.makeRemovalTransition(for: style)
            )
          )
          .task {
            let displayTime = transitionManager.toastAnimations.displayTime + transitionManager.toastAnimations.animationSpeed
            try? await Task.sleep(
              nanoseconds: UInt64(displayTime * 1_000_000_000)
            )
            dismissToast()
          }
        }
    }
  }
  
  private func presentToast(for isPresented: Bool) {
    if
      transitionManager.toastAnimations.isAnimationEnabled,
      let animation = transitionManager.makeAnimation() as? Animation {
      withAnimation(animation) {
        isPresenting = isPresented
      }
    } else {
      isPresenting = isPresented
    }
  }
  
  private func dismissToast() {
    if
      transitionManager.toastAnimations.isAnimationEnabled,
      let animation = transitionManager.makeAnimation() as? Animation {
      withAnimation(animation) {
        isPresented = false
        isPresenting = false
      }
    } else {
      isPresented = false
      isPresenting = false
    }
  }
}

struct CLToastModifiedView: View {
  let style: CLToastStyle
  let onDismiss: (() -> Void)?
  
  private var titleView: some View {
    Text(style.title)
      .foregroundColor(Color(uiColor: .label))
      .font(.title2)
  }
  
  private var descriptionView: (some View)? {
    if let description = style.description {
      Text(description)
        .foregroundColor(Color(uiColor: .label))
        .font(.footnote)
      
    } else { nil }
  }
  
  private var timelineView: (some View)? {
    if let timeline = style.timeline {
      Text(timeline)
        .foregroundColor(Color(uiColor: .secondaryLabel))
        .font(.caption)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: .bottomTrailing
        )
        .padding([.trailing, .bottom], 16)
      
    } else { nil }
  }
  
  private var imageView: (some View)? {
    if let image = style.image {
      Image(uiImage: image)
        .resizable()
      
    } else { nil }
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: style.layerCornerRadius)
        .fill(Color(uiColor: style.backgroundColor))
      
      if let imageView {
        HStack(
          alignment: .center,
          spacing: 0
        ) {
          imageView
            .frame(
              width: style.imageSize.width,
              height: style.imageSize.height
            )
            .aspectRatio(contentMode: .fit)
            .padding(.leading, 16)
          
          VStack(spacing: 0) {
            titleView
            
            descriptionView
          }
          .padding(.horizontal, 16)
          
          Spacer()
        }
        
        timelineView
        
      } else {
        VStack(spacing: 0) {
          titleView
          
          descriptionView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        
        timelineView
      }
    }
    .frame(height: style.height)
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 16)
    .onDisappear {
      if let onDismiss { onDismiss() }
    }
  }
}
