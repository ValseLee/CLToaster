//
//  CLToastSwiftUITransition.swift
//
//
//  Created by Celan on 2/19/24.
//

import SwiftUI

/**
 Customize your transition animation with ``CLToastSwiftUITransition``.
 ``CLToastSwiftUITransition`` also conforms ``CLToastAnimation``, so it needs ``CLToastAnimations``.
 
 Each transition is triggered by this framework internally like below.
 
 ```swift
 .transition(
   .asymmetric(
     insertion: transitionManager.makeInsertionTransition(for: style),
     removal: transitionManager.makeRemovalTransition(for: style)
   )
 )
 ```
 
 - Attention: Opaicty transition into specific value is not supported yet.
 It always becomes 1.0 or 0.0 when the toastView's insertion or removal.
 
 ``makeInsertionTransition(for:)`` : Make Insertion Transition.
 
 ``makeRemovalTransition(for:)`` : Make Removal Transition.
 */
public protocol CLToastSwiftUITransition: CLToastAnimation {
  
  /**
   Make Insertion Transition.
   - Parameter style: ``CLToastStyle`` for internal usage.
   - Returns: AnyTransition for Insertion
   
   Although ``CLToastSwiftUITransition`` implementation requires a ``CLToastAnimations``, but when you customize, you don't have to refer that.
   You can just make transition like below.
   
   ```swift
   func makeInsertionTransition(for style: CLToastStyle) -> AnyTransition {
     AnyTransition
       .offset(y: 40)
       .offset(x: 40)
       .combined(with: .opacity)
   }
   ```
   */
  func makeInsertionTransition(for style: CLToastStyle) -> AnyTransition
  
  /**
   Make Removal Transition.
   - Parameter style: ``CLToastStyle`` for internal usage.
   - Returns: AnyTransition for Removal
   */
  func makeRemovalTransition(for style: CLToastStyle) -> AnyTransition
}
