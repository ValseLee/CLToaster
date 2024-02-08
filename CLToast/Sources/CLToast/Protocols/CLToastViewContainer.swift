//
//  CLToastViewField.swift
//
//
//  Created by Celan on 2/6/24.
//

import UIKit

@dynamicMemberLookup
/// 임마 이거는 사용자의 Custom View와 내 CLToastView 둘다 대응할 수 있는 인터페이스임
/// CLToastViewType의 속성들을 바탕으로 path를 지정해서 Child View를 저장시킬거임
protocol CLToastViewContainer {
  associatedtype CLToastViewType: UIView
  var toastView: CLToastViewType { get set }
  init(of toastView: CLToastViewType)
  subscript(dynamicMember dynamicMember: KeyPath<CLToastViewType, UIView>) -> UIView { get }
}
