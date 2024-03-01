//
//  CLToastAnimationBuilder.swift
//
//
//  Created by Celan on 2/17/24.
//

public class CLToastAnimationBuilder {
  var animation: CLToastAnimations
  
  public init() {
    self.animation = CLToastAnimations()
  }
  
  public func assign<Value>(
    _ path: WritableKeyPath<CLToastAnimations,Value>,
    into newValue: Value
  ) -> Self {
    animation[keyPath: path] = newValue
    return self
  }
  
  public func build() -> CLToastAnimations { animation }
}
