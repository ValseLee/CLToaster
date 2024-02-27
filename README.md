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
      <img alt="Deploy Version" src="https://img.shields.io/badge/iOS-15.0%2B-orange?logo=swift">
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
      <img src = "https://img.shields.io/cocoapods/v/CLToaster"
    </td>
  </tr>
</table>

<p align = "center">
  iOS Library for Presenting Toast Message in UIKit & SwiftUI
  <br>
  <strong>
    Easy to Use, Easy to Customize || Convenient and Consistent
  </strong>
</p>

<div align = "center">
  <img width="604" alt="CLToastBanner" src="https://github.com/ValseLee/CLToaster/assets/82270058/c8592669-3c1d-441a-a3c3-c8cc8c2794bc">
</div>

---

<p align = "center">
  <h3 align = "center"> 🧩 Examples! </h2> 
</p>

<table align = "center">
  <tr>
    <th scope="col">Quick Toast</td>
    <th scope="col">Detailed Toast</td>
    <th scope="col">Animation Customized Toast</td>
    <th scope="col">Top Toast</td>
  </tr>
<!--   <tr>
    <td><img width="200" height = "400" src="https://github.com/ValseLee/CLToaster/assets/82270058/463ecc5f-952c-425e-b244-c32a21163adb"> </td>
    <td><img width="200" height = "400" src="https://github.com/ValseLee/CLToaster/assets/82270058/2363a55d-2ae5-474e-9dfa-a7fc4e4cbdac"> </td>
    <td><img width="200" height = "400" src="https://github.com/ValseLee/CLToaster/assets/82270058/1cfb0838-120a-4dab-a3c6-9340164ad78b"> </td>
    <td><img width="200" height = "400" src="https://github.com/ValseLee/CLToaster/assets/82270058/d79af81c-28e5-438e-b222-194de12947ed"> </td>
  </tr> -->
  <tr>
    <th>
      <video src = "https://github.com/ValseLee/CLToaster/assets/82270058/aeb8ab09-08e7-4ebe-8702-912dd19e86e9">
    </th>
    <th>
      <video src = "https://github.com/ValseLee/CLToaster/assets/82270058/a8473c03-3d3c-448e-9f98-fb9184a8ec34">
    </th>
    <th>
      <video src= "https://github.com/ValseLee/CLToaster/assets/82270058/e8e90e87-8f02-49dd-abf1-e32928905aa1"> 
    </th>
    <th>
      <video src = "https://github.com/ValseLee/CLToaster/assets/82270058/81ddf01a-e77e-4c82-a65a-caee3330af3c">
    </th>
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
- You can make common style and use it consistently in UIKit and SwiftUI.

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

### Presenting toast message from top.
- You can present your toast message from top, center and bottom.
- `CLToast` will present your toast from bottom by default.
  - in Quick Present, you can’t present it from other direction but bottom.
- Default animation will be automatically adjusted by its presentation section.

```swift
var style = CLToastStyle(title: "Title")
style.description = "Description"
style.timeline = Date().formatted()
style.image = UIImage(named: "MyImage")

// UIKit
CLToast(with: style, section: .top)
  .present(in: view)

// SwiftUI
var body: some View {
  YourView { /* code */ }
    .presentToast(
      isPresented: $isPresented,
      with: style,
      section: .top
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


