import UIKit

public struct CLToast {
  private var layerClient = CLToastViewLayerClient()
  private var animationManager: any CLToastUIKitAnimation
  private var viewBuilder: any CLToastViewBuildable
  
  public let style: CLToastStyle
  public let completion: (() -> Void)?
  
  /// Initialize ``CLToast`` Manager with Toast's title, frame height, display Direction.
  /// You can call this with basic toast message without a completion handler.
  /// - Parameters:
  ///   - title: ToastView's title
  ///   - height: ToastView's height, which is used for its ``heightAnchor``.
  ///   - displayDirection: ToastView's Display Direction. You can display toastView from top, bottom and center.
  ///   - completion: Closure that is called when current toastView has been completely disappeared. You can skip this when you don't have to call any callbacks. ToastView will be removed from parent view when its animation is ended by default.
  public init(
    title: String,
    height: CGFloat,
    displayDirection: CLToastDisplaySection,
    completion: (() -> Void)? = nil
  ) {
    self.style = CLToastStyleBuilder(title)
      .buildValue(\.height, into: height)
      .buildStyle()
     
    self.viewBuilder = CLToastViewBuilder(style: style)
    self.animationManager = CLToastUIKitAnimationClient()
    self.completion = nil
  }
  
  /// Initialize ``CLToast`` Manager with given parameters, style and completion handler.
  /// - Parameters:
  ///   - style: ``CLToastStyle`` which configures toastView's properties like title, description, display Duration, etc.
  ///   - completion: Closure that is called when current toastView has been completely disappeared. You can skip this when you don't have to call any callbacks. ToastView will be removed from parent view when its animation is ended by default.
  public init(
    with style: CLToastStyle,
    completion: (() -> Void)? = nil
  ) {
    self.style = style
    self.viewBuilder = CLToastViewBuilder(style: style)
    self.animationManager = CLToastUIKitAnimationClient()
    self.completion = completion
  }
  
  /**
   Initialize ``CLToast`` Manager with given parameters. Use this initializer when you want to customize your toastView's appearing and disappearing animation.
   - Parameters:
     - style: ``CLToastStyle`` which configures toastView's properties like title, description, display Duration, etc.
     - animation: Animation configuring object which conforms ``CLToastAnimatable``.
     - completion: Closure which is called when current toastView has been completely disappeared. You can skip this when you don't have to call any callbacks. ToastView will be removed from parent view when its animation is ended by default.
   
   When you use your own animationManager, you should manage toastView's removal from ``CLToastAnimatable.animate(for:completion:)`` since ``CLToast`` only calls the ``CLToastAnimatable.animate(for:completion:)`` before ``addSubview``.
   */
  public init(
    with style: CLToastStyle,
    animation: any CLToastUIKitAnimation,
    completion: (() -> Void)? = nil
  ) {
    self.animationManager = animation
    self.style = style
    self.viewBuilder = CLToastViewBuilder(style: style)
    self.completion = completion
  }
}

public extension CLToast {
  /**
   Present a ToastView with default ToastView built by given style.
   Its layout and components are determined by user configured style which is injected when ``CLToast`` has been initialized.
    - Parameter view: Parent view. ToastView will become a subview of this.
   */
  func present(in view: UIView) {
    guard let toastView = buildToastView(with: style) else { return }
    layerClient.configLayer(for: toastView, with: style)
    if let completion { toastView.onDismiss = completion }
    if animationManager.toastAnimations.isAnimationEnabled {
      animate(toastView)
      addSubview(toastView, for: view)
    } else {
      Task { await present(in: view, toastView: toastView) }
    }
  }
  
  func animate(_ toastView: UIView) {
    if
      let appearingAnimation = animationManager.makeAnimation() as? UIViewPropertyAnimator,
      let disappearingAnimation = animationManager.makeAnimation() as? UIViewPropertyAnimator {
      
      disappearingAnimation.buildAnimation {
        animationManager.disappearing(toastView: toastView)
      }
      
      appearingAnimation.buildAnimation {
        animationManager.appearing(toastView: toastView)
      }
      .addCompletion { state in
        if case .end = state {
          disappearingAnimation.startAnimation(afterDelay: animationManager.toastAnimations.displayTime)
        }
      }
      
      appearingAnimation.startAnimation()
    }
  }
}

// MARK: - UIKit
internal extension CLToast {
  /**
   Present a ToastView with default ToastView built by given style.
   This method is being called when the style is not animatable.
   - Parameters:
   - view: Parent view. ToastView will become a subview of this.
   - toastView: ToastView which is displayed for ``displayTimeInterval`` long.
   */
  @MainActor
  private func present(in view: UIView, toastView: CLToastView) async {
    toastView.layer.opacity = 1.0
    addSubview(toastView, for: view)
    try? await Task.sleep(nanoseconds: UInt64(animationManager.toastAnimations.displayTime * 1_000_000_000))
    toastView.removeFromSuperview()
  }
  
  func addSubview(_ toastView: UIView, for view: UIView) {
    view.addSubview(toastView)
    configAutoLayout(of: toastView, in: view)
  }
  
  func buildToastView(with style: CLToastStyle) -> CLToastView? {
    guard let toastView = viewBuilder.buildToastView() else { return nil }
    return toastView as? CLToastView
  }
  
  func configAutoLayout(of toastView: UIView, in view: UIView) {
    toastView.translatesAutoresizingMaskIntoConstraints = false
    
    switch animationManager.toastAnimations.animateFrom {
    case .top:
      toastView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    case .bottom:
      toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    case .center:
      toastView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      toastView.heightAnchor.constraint(equalToConstant: style.height)
    ])
  }
}
