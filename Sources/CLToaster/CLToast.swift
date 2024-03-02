import Common
import UIKit
import UIKitToaster

/**
 Toast manager for UIKit.
 
 When you want to present a toast message, initialize this and ``present(in:)``.
 You can initialize this struct with ``CLToastStyle`` or simply title and height.
 Also you can customize animation for ``CLToast``.
 */
public struct CLToast {
  var data: CLToastUIKitData
  
  /**
   Present a ToastView with given parameters.
   
   Initialize ``CLToast`` with Toast's title, frame height, display Direction.
   You can call Quick Toast without a completion handler.
    - Parameters:
      - title: ToastView's title
      - height: ToastView's height, which is used for its heightAnchor.
      - completion: Closure that is called when current ToastView has been completely disappeared, right after ``removeFromSuperview()`` been called. You can skip ``completion`` when you don't have to call any callbacks. ToastView will be dismissed when its animation is in ``.end`` state of ``UIViewAnimatingPosition`` by default.
   */
  public init(
    title: String,
    height: CGFloat,
    completion: (() -> Void)? = nil
  ) {
    let style = CLToastStyleBuilder(title)
      .assign(\.height, into: height)
      .build()
    
    self.data = CLToastUIKitData(
      style: style,
      display: .bottom,
      completion: completion
    )
  }
  
  /**
   Present a ToastView with given parameters.
   
   Initialize ``CLToast`` with given parameters, style and completion handler.
    - Parameters:
      - style: ``CLToastStyle`` which configures toastView's properties like title, description, timeline and radius etc.
      - section: A value which decides toastView's display section. Default value is ``.bottom``. You can display toast View from top, bottom and center.
      - completion: Closure that is called when current ToastView has been completely disappeared, right after ``removeFromSuperview()`` been called. You can skip ``completion`` when you don't have to call any callbacks. ToastView will be dismissed when its animation is in ``.end`` state of ``UIViewAnimatingPosition`` by default.
   */
  public init(
    with style: CLToastStyle,
    section: CLToastDisplaySection = .bottom,
    completion: (() -> Void)? = nil
  ) {
    self.data = CLToastUIKitData(
      style: style,
      display: section,
      completion: completion
    )
  }
  
  /**
   Present a ToastView with given parameters.
   
   - Parameters:
      - style: ``CLToastStyle`` which configures toastView's properties like title, description, timeline and cornerRadius etc.
      - animation: Animation configuring struct/class which conforms ``CLToastUIKitAnimation``.
      - section: A value which decides toastView's display section. Default value is ``.bottom``. You can display toast View from top, bottom and center.
      - completion: Closure that is called when current ToastView has been completely disappeared, right after ``removeFromSuperview()`` been called. You can skip ``completion`` when you don't have to call any callbacks. ToastView will be dismissed when its animation is in ``.end`` state of ``UIViewAnimatingPosition`` by default.
   
   If you want to use your own animation, you should manage toastView's animations conforming ``CLToastUIKitAnimation`` which asks you to implement your custom animations for appearing and disappearing.
   ``CLToast`` configures your completion and animation flow to animate toastView smoothly.
   Disappearing animation would be triggered after delay which is set by ``CLToastAnimations`` value, ``displayTime``.
   */
  public init(
    with style: CLToastStyle,
    animation: any CLToastUIKitAnimation,
    section: CLToastDisplaySection = .bottom,
    completion: (() -> Void)? = nil
  ) {
    self.data = CLToastUIKitData(
      style: style,
      animation: animation,
      display: section,
      completion: completion
    )
  }
  
  public func present(in view: UIView) {
    UIKitToaster(data: data)
      .present(in: view)
  }
}
