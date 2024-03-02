//
//  CLToastViewSection.swift
//
//
//  Created by Celan on 2/7/24.
//

import UIKit

public enum CLToastViewSection: CaseIterable {
  case title, description, timeline, image
  
  public var identifier: String {
    switch self {
    case .title: "TITLE"
    case .description: "DESCRIPTION"
    case .timeline: "TIMELINE"
    case .image: "IMAGE"
    }
  }
}
