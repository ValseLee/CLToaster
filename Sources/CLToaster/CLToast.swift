import UIKit

/**
 Toast manager for UIKit.
 
 When you want to present a toast message, initialize this and ``present(in:)``.
 You can initialize this struct with ``CLToastStyle`` or simply title and height.
 Also you can customize animation for ``CLToast``.
 */
public struct CLToast {
  private let layerClient = CLToastViewLayerClient()
  private let animationManager: any CLToastUIKitAnimation
  private let gestureManager = CLToastUIKitGestureManager()
  private let viewContainer: CLToastUIViewContainer
  
  private let style: CLToastStyle
  private let completion: (() -> Void)?
  
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
    self.style = CLToastStyleBuilder(title)
      .assign(\.height, into: height)
      .build()
    
    self.viewContainer = CLToastUIViewContainer(style: style)
    let animation = CLToastAnimations()
    self.animationManager = CLToastUIKitAnimationClient(toastAnimations: animation)
    self.completion = nil
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
    var styleCopy = style
    styleCopy.section = section
    self.style = styleCopy
    
    self.viewContainer = CLToastUIViewContainer(style: styleCopy)
    let animation = CLToastAnimations()
    self.animationManager = CLToastUIKitAnimationClient(toastAnimations: animation)
    self.completion = completion
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
    self.animationManager = animation
    var styleCopy = style
    styleCopy.section = section
    self.style = styleCopy
    self.viewContainer = CLToastUIViewContainer(style: styleCopy)
    self.completion = completion
  }
}

public extension CLToast {
  class CLToastActionWrapper {
    @objc static func dosth() {
      print(#function)
    }
  }
  
  /**
   Present a ToastView over UIView with given style.
   Its layout and components are determined by user configured style which is injected when ``CLToast`` has been initialized.
   - Parameter view: Parent view. ToastView will become a subview of this.
   */
  func present(in view: UIView) {
    let toastView = viewContainer.makeToastView(with: completion)
    
    layerClient.configLayer(for: toastView, with: style)
    if animationManager.toastAnimations.isAnimationEnabled {
      animate(toastView)
      addSubview(toastView, for: view)
    } else {
      Task {
        await present(in: view, toastView: toastView)
      }
    }
  }
}

// MARK: - UIKit
extension CLToast {
  /**
   Present a ToastView with default ToastView built by given style.
   This method is being called when the style is not animatable.
   - Parameters:
   - view: Parent view. ToastView will become a subview of this.
   - toastView: ToastView which is displayed for ``displayTimeInterval`` long.
   */
  @MainActor
  private func present(in view: UIView, toastView: CLToastView) async {
    gestureManager.makeTapGesture(for: toastView) {
      toastView.removeFromSuperview()
    }
    
    toastView.layer.opacity = 1.0
    addSubview(toastView, for: view)
    try? await Task.sleep(nanoseconds: UInt64(animationManager.toastAnimations.displayTime * 1_000_000_000))
    toastView.removeFromSuperview()
  }
  
  func addSubview(_ toastView: UIView, for view: UIView) {
    view.addSubview(toastView)
    configAutoLayout(of: toastView, in: view)
  }
  
  func configAutoLayout(of toastView: UIView, in view: UIView) {
    toastView.translatesAutoresizingMaskIntoConstraints = false
    
    switch style.section {
    case .top:
      toastView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: style.verticalPadding).isActive = true
    case .bottom:
      toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -style.verticalPadding).isActive = true
    case .center:
      toastView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: style.horizontalPadding),
      toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -style.horizontalPadding),
      toastView.heightAnchor.constraint(equalToConstant: style.height)
    ])
  }
  
  // TODO: - Animator
  func animate(_ toastView: UIView) {
    if
      let appearingAnimation = animationManager.makeAnimation() as? UIViewPropertyAnimator,
      let disappearingAnimation = animationManager.makeAnimation() as? UIViewPropertyAnimator {
      let displayTime = DispatchTime.now()
      + animationManager.toastAnimations.displayTime
      + animationManager.toastAnimations.animationSpeed
      
      toastView.isUserInteractionEnabled = true
      
      gestureManager.makeTapGesture(for: toastView) {
        appearingAnimation.stopAnimation(false)
        disappearingAnimation.startAnimation()
      }
      
      appearingAnimation
        .addAnimations {
          animationManager.makeAppearingAnimation(toastView: toastView, for: style)
        }
      
      disappearingAnimation
        .addAnimations {
          animationManager.makeDisappearingAnimation(toastView: toastView, for: style)
        }
      
      disappearingAnimation
        .addCompletion { state in
          if case .end = state { toastView.removeFromSuperview() }
        }
      
      appearingAnimation.startAnimation()
      
      DispatchQueue.main.asyncAfter(deadline: displayTime) {
        disappearingAnimation.startAnimation()
      }
    }
  }
}
