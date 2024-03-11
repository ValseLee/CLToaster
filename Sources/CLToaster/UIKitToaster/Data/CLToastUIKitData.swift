//
//  CLToastUIKitData.swift
//
//
//  Created by Celan on 3/2/24.
//

struct CLToastUIKitData {
  var style: CLToastStyle
  var animation: any CLToastUIKitAnimation
  var display: CLToastDisplaySection = .bottom
  var completion: (() -> Void)?
  
  init(
    style: CLToastStyle,
    animation: any CLToastUIKitAnimation = CLToastUIKitAnimationClient(toastAnimations: CLToastAnimations()),
    display: CLToastDisplaySection,
    completion: ( () -> Void)? = nil
  ) {
    self.style = style
    self.animation = animation
    self.display = display
    self.completion = completion
  }
}
