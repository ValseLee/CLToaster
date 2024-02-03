import UIKit

public protocol CLToastPresentStyle { }
public enum OverViewController: CLToastPresentStyle { }
public enum OverNavigationBar: CLToastPresentStyle { }

public struct CLToast<Present: CLToastPresentStyle> {
  private var toastPresentable: CLToastPresentable
  
  private func removeToastPresentable(isAnimated: Bool) {
    if isAnimated,
       toastPresentable.parent != nil {
      toastPresentable.removeFromParent()
      toastPresentable.view.removeFromSuperview()
      toastPresentable.dismiss(animated: true, completion: toastPresentable.onDismiss)
    }
  }
}

extension CLToast where Present == OverViewController {
  public func present(
    in vc: UIViewController,
    onDismiss: (() -> Void)? = { }
  ) {
    if let onDismiss { toastPresentable.onDismiss = onDismiss }
    present(in: vc)
  }
  
  public func present(in vc: UIViewController) {
    Task { @MainActor [weak vc] in
      guard let vc else { return }
      vc.addChild(toastPresentable)
      vc.view.addSubview(toastPresentable.view)
      toastPresentable.didMove(toParent: vc)
      toastPresentable.view.frame = vc.view.bounds
    }
  }
}

extension CLToast where Present == OverNavigationBar {
  public func present(
    in vc: UIViewController,
    onDismiss: (() -> Void)? = { }
  ) {
    if let onDismiss { toastPresentable.onDismiss = onDismiss }
    present(in: vc)
  }
  
  public func present(
    in vc: UIViewController
  ) {
    Task { @MainActor [weak vc] in
      guard
        let vc,
        let navigationController = vc.navigationController else { return }
      navigationController.addChild(toastPresentable)
      navigationController.navigationBar.addSubview(toastPresentable.view)
      navigationController.beginAppearanceTransition(true, animated: true)
      navigationController.endAppearanceTransition()
      toastPresentable.didMove(toParent: navigationController)
      toastPresentable.view.frame = navigationController.navigationBar.bounds
    }
  }
}
