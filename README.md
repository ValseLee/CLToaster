<p align = "center">
  <h1 align = "center"> 🌿 CLToaster </h1>
</p>

<table align = "center">
  <tr>
    <td>
      <a href = "mailto:sollleky72@gmail.com">
      <img src = "https://img.shields.io/badge/contact-@CelanLee-green.svg?style=flat&label=Contact&logo=gmail">
      </a>
    </td>
    <td>
      <img alt = "GitHub Repo stars" src = "https://img.shields.io/github/stars/valselee/cltoaster">
    </td>
    <td>
      <img src = "https://img.shields.io/github/license/valselee/CLToaster?label=LICENSE"> </td>
    <td>
      <img src = "https://img.shields.io/cocoapods/p/CLToaster?logo=swift&label=Platform">
    </td>
    <td>
      <img alt = "GitHub Release" src = "https://img.shields.io/github/v/release/valselee/cltoaster?include_prereleases&logo=github&label=Release">
    </td>
    <td>
      <img src = "https://img.shields.io/cocoapods/v/CLToaster">
    </td>
  </tr>
</table>

<p align = "center">
  Swift Library for Presenting Toast Message in UIKit & SwiftUI
  <br>
  <strong>
    Easy to Use, Easy to Customize || Convenient and Consistent
  </strong>
</p>

<div align = "center">
  <img src = "https://github.com/ValseLee/CLToaster/assets/82270058/6c0a709f-8dd0-47bd-9213-21a8f92687af" width = "100%">
</div>

<hr>

<p align = "center">
  <h4 align = "center"> Examples! </h2> 
</p>

<table align = "center">
  <tr>
    <th scope="col"> Quick Toast </td>
    <th scope="col"> Detailed Toast </td>
    <th scope="col"> Custom Animation </td>
    <th scope="col"> Bottom Toast </td>
  </tr>
  <tr>
    <td>
      <img src="">
    </td>
    <td>
      <img src="">
    </td>
    <td>
      <img src="">
    </td>
    <td>
      <img src="">
    </td>
  </tr>
</table>

---
### Easy-to-use
1. You can simply initialize `CLToast` and present.
2. You can use `CLToastStyle` struct to manage toast message’s Title, Description, Image, and Timeline.
3. Basic animation/transition(offset & opacity) is provided by the framework.

### Easy-to-customize
1. You can customize animation/transition with your own taste.
2. In UIKit, you will conform the protocol `CLToastUIKitAnimation`.
3. Otherwise, In SwiftUI, you will conform the protocol `CLToastSwiftUITransition`.

> 👀 **Let's see how it works!**

---
## Basics
- With `CLToast`, You can present a toast message using several methods.
- Whether you use UIKit or SwiftUI, `CLToast` can be used consistently.
- Follow the examples below.

### Quick Toast with title and height.
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

### Detailed Toast message with style.
- `CLToastStyle` can be used in UIKit and SwiftUI **equally**.
- You can make it common style and use it **consistently**.

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

### Presenting toast message from bottom.
- You can present your toast message from top, center and bottom.
- `CLToast` will present your toast from top by default.
  - in Quick Present, you can’t present it from other direction but top.
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
- You can customize toast message’s animation/transition.
- You have to make an implementation of `CLToastUIKitAnimation` or `CLToastSwiftUITransition`.
- Each of protocol will provide you a blueprint.
- WORK IN PROCESS!

```swift
// 1. First, you need ``CLToastAnimations`` which has animationSpeed and displayTime, etc.
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
---

## Cocoapods

```ruby
pod 'CLToaster'
```

## Swift Package Manager
```yml
Package URL: https://github.com/ValseLee/CLToast/
branch: `main`
```

## Carthage
> **WORK-IN-PROCESS**

---
## Update Roadmap
> ``CLToaster`` is in beta, so it would be updating continuously. <br>
> And it might take some time to update below items.

|         | View Customize | Animation Customize | Gesture Customize | Apply Queue | 🚏 More |
| :---    | :---: | :---: | :---: | :---: | :---: | 
| **UIKit**   |  | ✅ |    |   |  |
| **SwiftUI** |  |  ✅  |    |   |  | 

---
## It is Opened to everyone, btw.
- Your idea and issue really matter.
- Tell me with issue or fork this repository and make PR to contribute!


