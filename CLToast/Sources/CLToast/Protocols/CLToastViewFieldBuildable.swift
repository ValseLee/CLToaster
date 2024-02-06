//
//  CLToastViewBuildable.swift
//  
//
//  Created by Celan on 2/6/24.
//

import UIKit

protocol CLToastViewFieldBuildable: AnyObject {
  func makeLabel(
    in container: inout any CLToastViewField,
    for path: WritableKeyPath<any CLToastViewField, UILabel?>,
    config makeView: @escaping () -> UILabel
  )
  
  func makeImageView(
    in container: inout any CLToastViewField,
    for path: WritableKeyPath<any CLToastViewField, UIImageView?>,
    config makeView: @escaping () -> UIImageView
  )
}

@dynamicMemberLookup
protocol CLToastViewField {
  var titleLabel: UILabel? { get set }
  var descriptionLabel: UILabel? { get set }
  var timelineLabel: UILabel? { get set }
  var imageView: UIImageView? { get set }
  
  subscript(dynamicMember dynamicMember: KeyPath<Self, UIView>) -> UIView { get }
}
