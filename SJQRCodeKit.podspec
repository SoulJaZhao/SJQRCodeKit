#
# Be sure to run `pod lib lint SJQRCodeKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  #名称
  s.name             = 'SJQRCodeKit'
  #版本号
  s.version          = '1.0.0'
  #简介
  s.summary          = '二维码相关功能库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
提供二维码相关功能
                       DESC
  #主页,这里要填写可以访问到的地址，不然验证不通过
  s.homepage         = 'https://github.com/SoulJaZhao/SJQRCodeKit.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  #开源协议
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  #作者
  s.author           = { 'SoulJaZhao' => 'superzhaolong@126.com' }
  #这里的s.source须指向存放源代码的链接地址，而不是托管spec文件的repo地址
  s.source           = { :git => 'https://github.com/SoulJaZhao/SJQRCodeKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  #支持的平台及版本
  s.ios.deployment_target = '8.0'

  s.source_files = 'SJQRCodeKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SJQRCodeKit' => ['SJQRCodeKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  #所需的framework，多个用逗号隔开
  s.frameworks = 'UIKit', 'CoreGraphics', 'AVFoundation', 'CoreImage'
  # s.dependency 'AFNetworking', '~> 2.3'
end
