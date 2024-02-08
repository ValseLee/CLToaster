//
//  CLDefaultToastViewSection.swift
//
//
//  Created by Celan on 2/7/24.
//

import UIKit

public enum CLDefaultToastViewSection {
  case title(String)
  case description(String)
  case timeline(String)
  case image(UIImage?, CGSize)
  
  var identifier: String {
    switch self {
    case .title(_):
      "TITLE"
    case .description(_):
      "DESCRIPTION"
    case .timeline(_):
      "TIMELINE"
    case .image(_, _):
      "IMAGE"
    }
  }
}
