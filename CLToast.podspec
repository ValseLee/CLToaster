Pod::Spec.new do |spec|
  spec.name             = 'CLToast'
  spec.version          = '0.0.1-beta'
  spec.license          = 'Open Source'
  spec.homepage         = 'https://github.com/valselee/CLToast'
  spec.authors          = { 'Celan Lee' => 'sollleky72@gmail.com' }
  spec.summary          = '🌿 iOS Library for Convenience Toast Message UI & Animation!'
  spec.source           = {
    :git => 'https://github.com/valselee/CLToast.git',
    :tag => spec.version,
    :branch => "main"
  }
  spec.source_files     = 'Sources/**/*.swift'
  spec.platform         = :ios, '15.0'
  spec.swift_version    = '5.5'
  spec.ios.deployment_target = '15.0'
  spec.framework        = 'UIKit', 'SwiftUI'

end