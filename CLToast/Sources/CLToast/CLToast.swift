import UIKit

public struct CLToastComponent {
  var title: String
  var description: String?
  var timeline: String?
  var image: UIImage?
  var animationDuration: TimeInterval
}

// MARK: Package Endpoint
open class CLToast {
  private var viewBuilder = CLToastViewBuilder()
  private var animationBuilder = CLToastAnimateClient()
  
  public init() { }
}

extension CLToast {
  public func present(in parent: UIViewController) {
    guard
      let nav = parent.navigationController,
      !nav.isNavigationBarHidden else { return }
    guard let toastView = try? viewBuilder
      .buildComponents(in: .description("HIHI"))
      .buildComponents(in: .title("Hi"))
      .buildToastView() else { return }
    
    toastView.frame = CGRect(
      origin:
        CGPoint(
          x: nav.navigationBar.bounds.origin.x,
          y: nav.navigationBar.bounds.origin.y - 40
        ),
      size: CGSize(
        width: nav.navigationBar.bounds.width,
        height: 70
      )
    )
    
    toastView.layer.opacity = 0.0
    toastView.layer.cornerRadius = 20
    toastView.backgroundColor = .red
    animationBuilder.animate(
      for: toastView,
      completion: dot(s:)
    )
    nav.navigationBar.addSubview(toastView)
  }
  
  private func dot(s: Bool) {
    print("NONO")
  }
}
