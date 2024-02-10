//
//  File.swift
//  
//
//  Created by Celan on 2/10/24.
//

public class CLToastStyleBuilder {
  var style: CLToastStyle
  
  public init(_ title: String) {
    self.style = CLToastStyle(title: title)
  }
  
  public func buildValue<Value>(
    _ path: WritableKeyPath<CLToastStyle,Value>,
    newValue: Value
  ) -> Self {
    style[keyPath: path] = newValue
    return self
  }
  
  public func buildStyle() -> CLToastStyle { style }
}
