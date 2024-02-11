//
//  CLDefaultToastViewSection.swift
//
//
//  Created by Celan on 2/7/24.
//

import UIKit

enum CLToastViewSection {
  case title, description, timeline, image
  
  var identifier: String {
    switch self {
    case .title:
      "TITLE"
    case .description:
      "DESCRIPTION"
    case .timeline:
      "TIMELINE"
    case .image:
      "IMAGE"
    }
  }
}
