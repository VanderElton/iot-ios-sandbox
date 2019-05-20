# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iot-ios-sandbox' do

  pod 'Alamofire', '~> 4.8.2'
  pod 'MSAL', '~> 0.4.1'

  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iot-ios-sandbox

  target 'iot-ios-sandboxTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'iot-ios-sandboxUITests' do
  
  pod 'Alamofire', '~> 4.8.2'
  pod 'MSAL', '~> 0.4.1'
  
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.name == "Debug" && defined?(target.product_type) && target.product_type == "com.apple.product-type.framework"
        config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = "YES"
      end
    end
  end
end
