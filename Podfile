# Uncomment the next line to define a global platform for your project
inhibit_all_warnings!
platform :ios, '13.0'
use_frameworks!


def app_pods
  # Architect
     pod 'MVVM-Swift', '1.1.0' # MVVM Architect for iOS Application.

     # Data
     pod 'ObjectMapper', '3.3.0' # Simple JSON Object mapping written in Swift.

     # Network
     pod 'Alamofire', '4.7.3' # Elegant HTTP Networking in Swift.
     pod 'AlamofireNetworkActivityIndicator', '2.3.0' # Controls the visibility of the network activity indicator on iOS using Alamofire.

     # Utils
     pod 'SwiftUtils', '4.2.1'
     pod 'AsyncSwift', '2.0.4'
     pod 'SDWebImage', '5.9.2'
     pod 'PureLayout', '3.1.6'
end

def test_pods
    pod 'Nimble', '9.0.0'
    pod 'Quick', '3.0.0'
    pod 'OHHTTPStubs/Swift', '9.0.0' # includes the Default subspec, with support for NSURLSession & JSON, and the Swiftier API wrappers
#    pod 'Mockingjay'
end
target 'DemoUnitTest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  project 'DemoUnitTest'
  app_pods

  target 'DemoUnitTestTests' do
    inherit! :search_paths
    test_pods
  end
end
