<p align = "center">
  <h1 align = "center"> CLToast </h1>
</p>

<!---
shield: Swift Package Index, Platforms
after deployed
-->

<p align = "center">
  Swift Library for Presenting Toast Message in UIKit, SwiftUI.
  <br>
  Easy to Use, Easy to Customize.
</p>

<!---
Examples in GIFs
--->

---
## Basic Usage's
- With `CLToast`, You can call a toast message using several methods.
- Whether you use UIKit or SwiftUI, `CLToast` can be used consistently.
- Follow the examples below.

```swift
// UIKit

// 1. Present Toast which has title only.

/**
1. First, Initialize ``CLToast`` with title, toast message's height and display direction.
2. Lastly, call a ``present(in:)`` to present a toast message. It will become a subview of the value which you pass as an argument.
*/ 
func presentBasicToast() {
  CLToast(title: "Title", height: 50, displayDirection: .top)
    .present(in: view)
}

// 2. Present Toast which has bunch of detail Information.

/**
1. First, initialize a ``CLToastStyle`` or ``CLToastStyleBuilder``.
2. Second, Injects details to it or build it.
3. Lastly, Initialize a ``CLToast`` with ``style`` and give a completion handler.
*/

// ``CLToast`` offers you a style builder, but you don't have to use it.
let style = CLToastStyleBuilder("Title")
  .buildValue(\.description, into: "Description")
  .buildValue(\.timeline, into: Date().formatted())
  .buildValue(\.image, into: UIImage(named: "MyAwesomeImage"))
  .buildStyle()

// You can simply initialize ``CLToastStyle`` and modify its properties, like this.
style.displayTimeInterval = 1.5

CLToast(with: style) { [weak self] in
  self?.completion()
}.present(in: view)

// SwiftUI

// 1. Present Toast which has title only.

/**
1. First, call a ``presentToast(isPresented:with:)`` from a view where you want to overlay your toast message.
*/

// TODO: add View Modifier example

// 2. Present Toast which has bunch of detail Information.

/**
1. First, call a ``presentToast(isPresented:with:)`` from a view where you want to overlay your toast message.
2. You should bind a state which will trigger the toast message to be appeared.
*/
let style = CLToastStyleBuilder("Title")
  .buildValue(\.description, into: "Description")
  .buildValue(\.timeline, into: Date().formatted())
  .buildValue(\.image, into: UIImage(named: "MyAwesomeImage"))
  .buildStyle()

var body: some View {
  VStack { }
  .presentToast(
    isPresented: $isPresented,
    with: style
  ) {
    print("Dismissed")
  }
}

```

---

## Cocoapods

## Swift Package Manager

## Carthage

---
## Update Roadmap
> ``CLToast`` is currently 'Work-in-Process' state.
> So it might take some time to update below items.

|         | View Customize | Animation Customize | Gesture Customize | Apply Queue | 🚏 More |
| :---    | :--- | :--- | :--- | :--- | :--- | 
| UIKit   |  | ✅ |    |   |  |
| SwiftUI |  |    |    |   |  | 

---
## It is Open Source, btw.



