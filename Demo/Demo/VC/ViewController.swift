//
//  ViewController.swift
//  Demo
//
//  Created by Celan on 1/22/24.
//

import CLToast
import UIKit

final class CLToastDemoVC: UIViewController {
  var detailedToastPresentButton: UIButton = UIButton()
  var basicToastPresentButton: UIButton = UIButton()
  var customizedAnimationToastPresentButton: UIButton = UIButton()
  var bottomToastPresentButton: UIButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "MAIN"
    view.backgroundColor = .systemBackground
    
    makeDetailedToastPresentButton()
    makeBasicToastPresentButton()
    makeCustomizedAnimationToastPresentButton()
    makeBottomToastPresentButton()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
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
  
  private func makeBasicToastPresentButton () {
    basicToastPresentButton.setTitle("Basic", for: .normal)
    basicToastPresentButton.setTitleColor(.systemGreen, for: .normal)
    
    view.addSubview(basicToastPresentButton)
    basicToastPresentButton.addTarget(self, action: #selector(presentBasicToast), for: .touchUpInside)
    basicToastPresentButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      basicToastPresentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      basicToastPresentButton.bottomAnchor.constraint(equalTo: detailedToastPresentButton.topAnchor, constant: -20),
      basicToastPresentButton.heightAnchor.constraint(equalToConstant: 50),
      basicToastPresentButton.widthAnchor.constraint(equalToConstant: 200),
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
    bottomToastPresentButton.setTitle("Bottom Toast", for: .normal)
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
      .buildValue(\.description, into: "Description")
      .buildValue(\.timeline, into: Date().formatted())
      .buildValue(\.image, into: .actions)
      .buildStyle()
    
    CLToast(with: style) { [weak self] in
      self?.completionHandler()
    }
    .present(in: view)
  }
  
  @objc
  private func presentBasicToast() {
    CLToast(title: "Title", height: 50, displayDirection: .top)
      .present(in: view)
  }
  
  @objc
  private func presentToastWithCustomizeAnimation() {
    let style = CLToastStyleBuilder("Title")
      .buildValue(\.animateSpeed, into: 1)
      .buildStyle()
    
    CLToast(with: style,animationManager: MyAnimationManager(style: style))
      .present(in: view)
  }
  
  @objc
  private func presentToastFromBottom() {
    let style = CLToastStyleBuilder("Bottom Toast")
      .buildValue(\.description, into: "Description Here")
      .buildValue(\.timeline, into: Date().formatted())
      .buildValue(\.displayFrom, into: .bottom)
      .buildStyle()
    
    CLToast(with: style)
      .present(in: view)
  }
  
  func completionHandler() { print(#function) }
}

struct MyAnimationManager: CLToastAnimatable {
  let style: CLToastStyle
  
  func animate(
    for view: UIView,
    completion: @escaping () -> Void
  ) {
    UIView.animate(withDuration: style.animateSpeed) {
      view.frame.origin.x += 20
    } completion: { isAnimated in
      if isAnimated {
        UIView.animate(
          withDuration: style.animateSpeed,
          delay: style.displayTimeInterval
        ) {
          view.frame.origin.y -= style.animateY
        } completion: { isAnimated in
          if isAnimated { view.removeFromSuperview() }
        }
      }
    }
  }
}
