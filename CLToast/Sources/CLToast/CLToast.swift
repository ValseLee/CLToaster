import UIKit

@available(iOS 13.0, *)
final class CLToastPresenter<PresentMode> {
  private var toastInfo: ToastInfo!
  private lazy var toastVC: CLToastVC? = {
    let vc = CLToastVC(icon: toastInfo.icon, message: toastInfo.message)
    return vc
  }()
  
  public init(_ toastInfo: ToastInfo) {
    self.toastInfo = toastInfo
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configAnimation() {
    // TODO: - Animation 설정 변경
  }
  
  public func configLayout() {
    // TODO: - Top? Bottom?
  }
}

@available(iOS 13.0, *)
extension CLToastPresenter where PresentMode == OverViewController {
  func present(
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
extension CLToastPresenter where PresentMode == OverNavigationController {
  func present(
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
