//
//  CLToastStyleBuilder.swift
//
//
//  Created by Celan on 2/10/24.
//

public class CLToastStyleBuilder: CLBuilder {
  var style: CLToastStyle
  
  public init(_ title: String) {
    self.style = CLToastStyle(title: title)
  }
  
  public func assign<Value>(
    _ path: WritableKeyPath<CLToastStyle,Value>,
    into newValue: Value
  ) -> Self {
    style[keyPath: path] = newValue
    return self
  }
  
  public func build() -> CLToastStyle { style }
}
