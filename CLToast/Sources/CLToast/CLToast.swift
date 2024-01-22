import UIKit

@available(iOS 13.0, *)
public final class CLToast<PresentMode> {
  private var toastInfo: ToastInfo!
  private lazy var toastVC: CLToastVC? = {
    let vc = CLToastVC(icon: toastInfo.icon, message: toastInfo.message)
    return vc
  }()
  
  public init(_ toastInfo: ToastInfo) {
    self.toastInfo = toastInfo
  }
  
  public func configAnimation() {
    // TODO: - Animation 설정 변경
  }
  
  public func configLayout() {
    // TODO: - Top? Bottom?
  }
}

@available(iOS 13.0, *)
extension CLToast where PresentMode == OverViewController {
  public func present(
    with info: ToastInfo,
    in vc: UIViewController
  ) {
    guard let toastVC else { return }
    Task { @MainActor in
      vc.addChild(toastVC)
      vc.view.addSubview(toastVC.view)
      toastVC.didMove(toParent: vc)
      toastVC.view.frame = vc.view.bounds
    }
  }
}

@available(iOS 13.0, *)
extension CLToast where PresentMode == OverNavigationController {
  public func present(
    with info: ToastInfo,
    in vc: UIViewController
  ) {
    Task { @MainActor in
      guard
        let navigationController = vc.navigationController,
        let toastVC else { return }
      navigationController.addChild(toastVC)
      navigationController.navigationBar.addSubview(toastVC.view)
      navigationController.beginAppearanceTransition(true, animated: true)
      navigationController.endAppearanceTransition()
      toastVC.didMove(toParent: navigationController)
      toastVC.view.frame = navigationController.navigationBar.bounds
    }
  }
}
