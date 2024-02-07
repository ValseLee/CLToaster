import UIKit

// MARK: Present Style Constraint
public protocol CLToastPresentStyle { }
public enum OverViewController: CLToastPresentStyle { }
public enum OverNavigationBar: CLToastPresentStyle { }

// MARK: Package Endpoint
open class CLToast<PresentOver: CLToastPresentStyle> {
  public var toastController: (any CLToastPresentable)?
  
  public init(toastController: (any CLToastPresentable)) {
    self.toastController = toastController
  }
  
  public init() {
    let defaultVC = CLToastDefaultVC()
    let defaultAnimation = CLToastAnimateClient()
    defaultVC.animationDelegate = defaultAnimation
    self.toastController = defaultVC
  }
}

extension CLToast where PresentOver == OverNavigationBar {
  public func present(in parent: UIViewController) {
    guard
      let toastController,
      let nav = parent.navigationController,
      !nav.isNavigationBarHidden else { return }
    nav.addChild(toastController)
    nav.navigationBar.addSubview(toastController.view)

    nav.beginAppearanceTransition(true, animated: true)
    nav.endAppearanceTransition()
    
    toastController.didMove(toParent: nav)
    toastController.view.frame = nav.navigationBar.bounds
  }
}

extension CLToast where PresentOver == OverViewController {
  public func present(in parent: UIViewController) {
    guard let toastController else { return }
    parent.addChild(toastController)
    parent.view.addSubview(toastController.view)
    
    toastController.didMove(toParent: parent)
    toastController.view.frame.size = CGSize(width: parent.view.bounds.width, height: 150)
  }
}
