# ``CLToaster``

CLToaster is **easy-to-use**, **easy-to-customize** Toast Framework!
Whether you use UIKit or SwiftUI, **CLToaster** can be used consistently.

### Easy-to-use
  - You can simply initialize ``CLToast`` and present.
  - You can use ``CLToastStyle`` struct to manage toast message's **Title, Description, Image, and Timeline**.
  - Basic animation(offset & opacity) is provided by the framework.

### Easy-to-customize
  - You can customize animation with your own taste.
  - In UIKit, you will conform the protocol ``CLToastUIKitAnimation``.
  - Otherwise, In SwiftUI, you will conform the protocol ``CLToastSwiftUITransition``.

## Overview
### Quick present with title and height.

```swift

// UIKit
CLToast(title: "Title", height: 50)
  .present(in: view)

// SwiftUI
var body: some View {
  YourView { /* code */ }
    .presentToast(
      isPresented: $isPresented,
      title: "Title",
      height: 50
    )
}

```

### Presenting detailed toast message with style.
- ``CLToastStyle`` can be used in UIKit and SwiftUI **equally**.
- You can make it common style and use it consistently.

```swift

// Common style
var style = CLToastStyle(title: "Title")
style.description = "Description"
style.timeline = Date().formatted()
style.image = UIImage(named: "MyImage")

// UIKit
CLToast(with: style)
  .present(in: view)

// SwiftUI
var body: some View {
  YourView { /* code */ }
    .presentToast(
      isPresented: $isPresented,
      with: style
    )
}

```

### Present your toast message from bottom.
- You can present your toast message from top, center and bottom.
- ``CLToast`` will present your toast from top by default.
- in Quick Present, you can't present it from other direction but top.
- Default animation will be automatically adjusted by its presentation section.

```swift
var style = CLToastStyle(title: "Title")
style.description = "Description"
style.timeline = Date().formatted()
style.image = UIImage(named: "MyImage")

// UIKit
CLToast(with: style, section: .bottom)
  .present(in: view)

// SwiftUI
var body: some View {
  YourView { /* code */ }
    .presentToast(
      isPresented: $isPresented,
      with: style,
      section: .bottom
    )
}
```

### Customize your toast message with your animation.
- You can customize toast message's animation.
- You have to make an implementation of ``CLToastUIKitAnimation`` or ``CLToastSwiftUITransition``.
- Each of protocol will provide you a blueprint.
- WORK IN PROCESS

```swift

// 1. First you need ``CLToastAnimations`` which has animationSpeed and displayTime, etc.
// This animation model is also can be used commonly in UIKit, and SwiftUI.
var animation = CLToastAnimations()
animation.animatonSpeed = 0.5
animation.displayTime = 1.5

// 2. Then you make an implementation of ``CLToastUIKitAnimation`` or ``CLToastSwiftUITransition``.
struct MyCLToastAnimation: CLToastUIKitAnimation {
  let toastAnimations: CLToastAnimations

  // 3. Here, You make an animation for when the toast message is appearing.
  func makeAppearingAnimation(toastView: UIView, for style: CLToastStyle) {
    toastView.layer.opacity = toastAnimations.opacity
    toastView.frame.origin.y += toastAnimation.offsetY
    toastView.frame.origin.x += 40
  }

  // 4. Make an animation for when the toast message is disappearing.
  func makeDisappearingAnimation(toastView: UIView, for style: CLToastStyle) {
    toastView.layer.opacity = 0
    toastView.frame.origin.y -= toastAnimation.offsetY
  }

  // 5. Make an animator which manages above animations.
  func makeAnimation() -> UIViewPropertyAnimator {
    return UIViewPropertyAnimator(
      duration: toastAnimations.animationSpeed,
      curve: .easeInOut
    )
  }
}

// 6. With above CLToastAnimations, initialize your animation implementation.
let animationImplementation = MyCLToastAnimation(toastAnimations: animation)

// 7. ✨ And it's done!
CLToast(with: style, animation: animationImplementation)
  .present(in: view)

```
