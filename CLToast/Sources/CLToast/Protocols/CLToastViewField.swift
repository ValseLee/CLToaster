//
//  CLToastViewField.swift
//
//
//  Created by Celan on 2/6/24.
//

import UIKit

@dynamicMemberLookup
protocol CLToastViewField {
  associatedtype CLToastViewType: UIView
  var toastView: CLToastViewType { get set }
  init(of toastView: CLToastViewType)
  subscript(dynamicMember dynamicMember: KeyPath<CLToastViewType, UIView>) -> UIView { get }
}

struct CLToastViewFieldContainer<T: UIView>: CLToastViewField {
  typealias CLToastViewType = T
  var toastView: CLToastViewType
  
  init(of toastView: T) {
    self.toastView = toastView
  }
  
  subscript(dynamicMember dynamicMember: KeyPath<CLToastViewType, UIView>) -> UIView {
    return toastView[keyPath: dynamicMember]
  }
}
