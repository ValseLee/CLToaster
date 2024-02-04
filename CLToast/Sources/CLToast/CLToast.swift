import UIKit

// MARK: Present Style Constraint
public protocol CLToastPresentStyle { }
public enum OverViewController: CLToastPresentStyle { }
public enum OverNavigationBar: CLToastPresentStyle { }

// MARK: Package Endpoint
open class CLToast<PresentOver: CLToastPresentStyle> {
  public weak var toastController: CLToastPresentable?
}

extension CLToast where PresentOver == OverNavigationBar {
  public func present(in parent: UIViewController) {
    guard
      let toastController,
      let nav = parent.navigationController else { return }
    nav.beginAppearanceTransition(true, animated: true)
    toastController.present(in: nav)
    nav.endAppearanceTransition()
  }
}

extension CLToast where PresentOver == OverViewController {
  public func present(in parent: UIViewController) {
    guard let toastController else { return }
    toastController.present(in: parent)
  }
}
