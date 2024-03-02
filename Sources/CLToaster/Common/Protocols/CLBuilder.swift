//
//  CLBuilder.swift
//
//
//  Created by Celan on 3/1/24.
//

import Foundation

public protocol CLBuilder {
  associatedtype Target
  func assign<Value>(
    _ path: WritableKeyPath<Target, Value>,
    into newValue: Value
  ) -> Self
  
  func build() -> Target
}
