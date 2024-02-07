//
//  File.swift
//  
//
//  Created by Celan on 2/7/24.
//

import Foundation

protocol CLToastViewStyle {
  var imageView: UIImageView? { get set }
  var titleLabel: UILabel? { get set }
  var descriptionLabel: UILabel? { get set }
  var timelineLabel: UILabel? { get set }
}

