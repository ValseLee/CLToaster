//
//  CLToastInfo.swift
//
//
//  Created by Celan on 1/22/24.
//

import UIKit

public enum OverViewController { }
public enum OverNavigationController { }

public struct ToastInfo {
  let icon: UIImage
  let message: String
  
  public init(icon: UIImage, message: String) {
    self.icon = icon
    self.message = message
  }
}
