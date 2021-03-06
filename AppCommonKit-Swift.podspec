#
# Be sure to run `pod lib lint AppCommonKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppCommonKit-Swift'
  s.version          = '0.1.0'
  s.summary          = 'iOS 开发通用工具集 Swift版'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lilong-git/AppCommonKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lilong-git' => 'long_li@aliyun.com' }
  s.source           = { :git => 'https://github.com/lilong-git/AppCommonKit.git', :tag => s.version.to_s }
  s.swift_versions = '4.2'
  s.ios.deployment_target = '9.0'

  s.subspec 'AppUIAdaptor' do |ss|
      ss.source_files = 'AppUIAdaptor/**/*'
  end
  s.subspec 'AppExtensions' do |ss|
      ss.source_files = 'AppExtensions/**/*'
  end
  s.subspec 'AppLogger' do |ss|
      ss.source_files = 'AppLogger/**/*'
      s.dependency 'Log'
  end

  # s.resource_bundles = {
  #   'AppCommonKit' => ['AppCommonKit/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
   s.dependency 'SwifterSwift'
   
end
