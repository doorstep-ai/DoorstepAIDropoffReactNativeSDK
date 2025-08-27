require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "DropoffSdk"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => min_ios_version_supported }
  s.source       = { :git => "https://github.com/doorstep-ai/DoorstepAIDropoffReactNativeSDK", :tag => "#{s.version}" }

  s.static_framework = true

  # Split the pod into a binary slice that only delivers the XCFramework
  # and a code slice that contains the Swift / Obj-C bridge.  By making the
  # code slice depend on the binary one we guarantee the framework is
  # present (and on the search-path) when the Swift files are compiled.

  s.subspec 'Binary' do |ss|
    ss.vendored_frameworks = "ios/DoorstepDropoffSDK.xcframework"
  end

  s.subspec 'Core' do |ss|
    ss.source_files = "ios/**/*.{h,m,mm,swift}"
    ss.exclude_files = "ios/DoorstepDropoffSDK.xcframework"
    ss.dependency "#{s.name}/Binary"
  end

  # Have the umbrella spec pull both subspecs in by default
  s.default_subspecs = 'Binary', 'Core'

# Use install_modules_dependencies helper to install the dependencies if React Native version >=0.71.0.
# See https://github.com/facebook/react-native/blob/febf6b7f33fdb4904669f99d795eba4c0f95d7bf/scripts/cocoapods/new_architecture.rb#L79.
if respond_to?(:install_modules_dependencies, true)
  install_modules_dependencies(s)
else
  s.dependency "React-Core"
end

  s.pod_target_xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '$(PODS_XCFRAMEWORKS_BUILD_DIR)/DoorstepDropoffSDK',
    'OTHER_SWIFT_FLAGS' => '-framework DoorstepDropoffSDK'
  }
end
