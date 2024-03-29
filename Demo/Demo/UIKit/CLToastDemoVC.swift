//
//  CLToastDemoVC.swift
//  Demo
//
//  Created by Celan on 1/22/24.
//

import CLToaster
import UIKit

final class CLToastDemoVC: UIViewController {
  var detailedToastPresentButton = UIButton()
  var basicToastPresentButton = UIButton()
  var customizedAnimationToastPresentButton = UIButton()
  var bottomToastPresentButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    makeDetailedToastPresentButton()
    makeBasicToastPresentButton()
    makeCustomizedAnimationToastPresentButton()
    makeBottomToastPresentButton()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  private func makeBasicToastPresentButton () {
    basicToastPresentButton.setTitle("Quick Toast", for: .normal)
    basicToastPresentButton.setTitleColor(.systemGreen, for: .normal)
    
    view.addSubview(basicToastPresentButton)
    basicToastPresentButton.addTarget(self, action: #selector(presentQuickToast), for: .touchUpInside)
    basicToastPresentButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      basicToastPresentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      basicToastPresentButton.bottomAnchor.constraint(equalTo: detailedToastPresentButton.topAnchor, constant: -20),
      basicToastPresentButton.heightAnchor.constraint(equalToConstant: 50),
      basicToastPresentButton.widthAnchor.constraint(equalToConstant: 200),
    ])
  }
  
  private func makeDetailedToastPresentButton() {
    detailedToastPresentButton.setTitle("Detail Toast", for: .normal)
    detailedToastPresentButton.setTitleColor(.systemPink, for: .normal)
    
    view.addSubview(detailedToastPresentButton)
    detailedToastPresentButton.addTarget(self, action: #selector(presentDetailedToast), for: .touchUpInside)
    detailedToastPresentButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      detailedToastPresentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      detailedToastPresentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      detailedToastPresentButton.heightAnchor.constraint(equalToConstant: 50),
      detailedToastPresentButton.widthAnchor.constraint(equalToConstant: 200),
    ])
  }
  
  private func makeCustomizedAnimationToastPresentButton() {
    customizedAnimationToastPresentButton.setTitle("Animation Custom", for: .normal)
    customizedAnimationToastPresentButton.setTitleColor(.systemBlue, for: .normal)
    
    view.addSubview(customizedAnimationToastPresentButton)
    customizedAnimationToastPresentButton.addTarget(self, action: #selector(presentToastWithCustomizeAnimation), for: .touchUpInside)
    customizedAnimationToastPresentButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      customizedAnimationToastPresentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      customizedAnimationToastPresentButton.topAnchor.constraint(equalTo: detailedToastPresentButton.bottomAnchor, constant: 20),
      customizedAnimationToastPresentButton.heightAnchor.constraint(equalToConstant: 50),
      customizedAnimationToastPresentButton.widthAnchor.constraint(equalToConstant: 200),
    ])
  }
  
  private func makeBottomToastPresentButton() {
    bottomToastPresentButton.setTitle("Top Toast", for: .normal)
    bottomToastPresentButton.setTitleColor(.systemBrown, for: .normal)
    
    view.addSubview(bottomToastPresentButton)
    bottomToastPresentButton.addTarget(self, action: #selector(presentToastFromBottom), for: .touchUpInside)
    bottomToastPresentButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      bottomToastPresentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      bottomToastPresentButton.topAnchor.constraint(equalTo: customizedAnimationToastPresentButton.bottomAnchor, constant: 20),
      bottomToastPresentButton.heightAnchor.constraint(equalToConstant: 50),
      bottomToastPresentButton.widthAnchor.constraint(equalToConstant: 200),
    ])
  }
  
  @objc
  private func presentDetailedToast() {
    let style = CLToastStyleBuilder("Title")
      .assign(\.description, into: "Description")
      .assign(\.timeline, into: Date().formatted())
      .assign(\.image, into: UIImage(named: "Logo"))
      .assign(\.height, into: 125)
      .build()
    
    CLToast(with: style) { [weak self] in
      self?.completionHandler()
    }
    .present(in: view)
  }
  
  @objc
  private func presentQuickToast() {
    CLToast(title: "Title", height: 100)
      .present(in: view)
  }
  
  @objc
  private func presentToastWithCustomizeAnimation() {
    let style = CLToastStyle(title: "Title")
    let animation = CLToastAnimations()
    
    CLToast(
      with: style,
      animation: MyAnimationManager(toastAnimations: animation)
    )
    .present(in: view)
  }
  
  @objc
  private func presentToastFromBottom() {
    let style = CLToastStyleBuilder("Top Toast")
      .assign(\.description, into: "Description Here")
      .assign(\.timeline, into: Date().formatted())
      .build()
    
    CLToast(with: style, section: .top)
      .present(in: view)
  }
  
  func completionHandler() { print(#function) }
}

struct MyAnimationManager: CLToastUIKitAnimation {
  var toastAnimations: CLToastAnimations
  
  func makeAppearingAnimation(toastView: UIView, for style: CLToastStyle) {
    toastView.layer.opacity = toastAnimations.opacity
    toastView.frame.origin.x += 40
  }
  
  func makeDisappearingAnimation(toastView: UIView, for style: CLToastStyle) {
    toastView.layer.opacity = 0.0
    toastView.frame.origin.x += 40
  }
  
  func makeAnimation() -> UIViewPropertyAnimator {
    UIViewPropertyAnimator(duration: toastAnimations.animationSpeed, curve: .easeInOut)
  }
}
