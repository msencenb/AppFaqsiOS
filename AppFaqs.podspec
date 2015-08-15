#
# Be sure to run `pod lib lint AppFaqs.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AppFaqs"
  s.version          = "1.0.1"
  s.summary          = "iOS SDK for https://appfaqs.co"
  s.description      = <<-DESC
                       Pod for easy integration of AppFaqs into your iOS app.
                       DESC
  s.homepage         = "https://appfaqs.co"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Matt Sencenbaugh" => "matt.sencenbaugh@gmail.com" }
  s.source           = { :git => "https://github.com/msencenb/AppFaqsiOS.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'AppFaqs' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
