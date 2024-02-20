Pod::Spec.new do |spec|
  spec.name             = 'CLToaster'
  spec.version          = '0.0.1-beta'
  # LICENSE IS NOT FOUND
  spec.license          = { :type => 'MIT' }
  spec.homepage         = 'https://github.com/valselee/CLToaster'
  spec.authors          = { 'Celan Lee' => 'sollleky72@gmail.com' }
  spec.summary          = '🌿 iOS Library for Convenience Toast Message UI & Animation!'
  spec.source           = {
    :git => 'https://github.com/valselee/CLToaster.git',
    :tag => spec.version,
    :branch => "main"
}
  spec.platform         = :ios, '15.0'
  spec.swift_version    = '5.5'
  spec.ios.deployment_target = '15.0'
  spec.framework        = 'UIKit', 'SwiftUI'
  spec.source_files = 'Sources/**/*.{swift}'
end
