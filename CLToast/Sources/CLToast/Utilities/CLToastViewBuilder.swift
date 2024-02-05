//
//  File.swift
//  
//
//  Created by Celan on 2/5/24.
//

import Foundation

public struct CLToastViewBuilder {
  func makeIconView(with image: UIImage) -> UIView {
    let view = UIView()
    
    return UIView()
  }
  
  func makeTitleLabelView(
    with text: String,
    config: @escaping (UILabel) -> Void
  ) -> UILabel {
    let titleLabel = UILabel()
    config(titleLabel)
    
    return titleLabel
  }
  
  func makeDescriptionView() -> UILabel {
    return UILabel()
  }
  
  func makeTimeLabel() -> UILabel {
    return UILabel()
  }
  
  func makeToastView() -> UIView {
    return UIView()
  }
}
