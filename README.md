<p align = "center">
  <h1 align = "center"> 🌿 CLToast </h1>
</p>

![License](https://img.shields.io/github/license/valselee/CLToast?label=LICENSE)
![Release](https://img.shields.io/github/v/release/ValseLee/CLToast?include_prereleases&display_name=tag&logo=swift)

<!---
shield: Swift Package Index, Platforms after deployed
-->

<p align = "center">
  Swift Library for Presenting Toast Message in UIKit, SwiftUI.
  <br>
  Easy to Use, Easy to Customize || Convenient and Consistent
</p>

| Quick present | Detailed Toast | Bottom Toast |
| :---: | :---: | :---: |
| | | |

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
- There is another `CLToast` pod with the same name
- So you have to specify the `git path` like below.
```ruby
pod 'CLToast', :git => 'https://github.com/Valselee/CLToast.git', :branch => 'main'
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
> ``CLToast`` is in beta, so it would be updating continuously.
> And it might take some time to update below items.

|         | View Customize | Animation Customize | Gesture Customize | Apply Queue | 🚏 More |
| :---    | :---: | :---: | :---: | :---: | :---: | 
| UIKit   |  | ✅ |    |   |  |
| SwiftUI |  |  ✅  |    |   |  | 

---
## It is Opened to everyone, btw.
- Your idea and issue really matter.
- Tell me with issue or fork this repository and make PR to contribute!


