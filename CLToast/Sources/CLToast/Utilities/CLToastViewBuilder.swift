//
//  File.swift
//  
//
//  Created by Celan on 2/5/24.
//

import UIKit

public struct CLToastViewBuilder {
  func makeIconView(
    config makeView: @escaping () -> UIImageView?
  ) -> UIImageView? {
    makeView()
  }
  
  func makeTitleLabel(
    config makeView: @escaping () -> UILabel?
  ) -> UILabel? {
    makeView()
  }
  
  func makeDescriptionLabel(
    config makeView: @escaping () -> UILabel?
  ) -> UILabel? {
    makeView()
  }
  
  func makeToastTimeLabel(
    config makeView: @escaping () -> UILabel?
  ) -> UILabel? {
    makeView()
  }
  
  func makeToastView() -> UIView {
    return UIView()
  }
}
