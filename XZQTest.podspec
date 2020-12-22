#
# Be sure to run `pod lib lint XZQTest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XZQTest'
  s.version          = '0.1.0'
  s.summary          = 'A short description of XZQTest.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/xiangzq/XZQTest'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiangzq' => 'xiangac1992@163.com' }
  s.source           = { :git => 'https://github.com/xiangzq/XZQTest.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'XZQTest/Classes/*'
  
  s.resource_bundles = {
     'XZQTest' => ['XZQTest/Assets/*.xcassets']
  }
  
  s.subspec 'Array' do |ss|
     ss.source_files = 'XZQTest/Classes/Array/*.{h,m}'
     ss.public_header_files = 'XZQTest/Classes/Array/*.{h}'
  end
    
  s.subspec 'Dictionary' do |ss|
     ss.source_files = 'XZQTest/Classes/Dictionary/*.{h,m}'
     ss.public_header_files = 'XZQTest/Classes/Dictionary/*.{h}'
  end


  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
