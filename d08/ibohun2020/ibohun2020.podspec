#
# Be sure to run `pod lib lint ibohun2020.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ibohun2020'
  s.version          = '0.1.0'
  s.summary          = 'My first pods for Swift'
  s.swift_version    = '5.1.3'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
These pods are so fresh as me when I get my first sexual experience.
                       DESC

  s.homepage         = 'https://github.com/znatno'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'znatno' => 'ivanbohuna@gmail.com' }
  s.source           = { :git => 'https://github.com/znatno/ibohun2020.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ibohun2020/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ibohun2020' => ['ibohun2020/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
