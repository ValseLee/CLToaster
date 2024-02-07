//
//  CLToastViewStyle.swift
//
//
//  Created by Celan on 2/7/24.
//

import Foundation

/// CLToast가 기본으로 제공하는 템플릿 View를 정의합니다.
/// 각각의 View는 이미 정해진 Layout으로 제공되며,
/// builder에 의해 build된 컴포넌트에 따라 View를 구성합니다.
protocol CLToastViewStyle {
  var imageView: UIImageView? { get set }
  var titleLabel: UILabel? { get set }
  var descriptionLabel: UILabel? { get set }
  var timelineLabel: UILabel? { get set }
}

