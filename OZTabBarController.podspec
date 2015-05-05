#
# Be sure to run `pod lib lint OZTabBarController.podspec.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "OZTabBarController"
  s.version          = "0.2.2"
  s.summary          = "Lightweight tab bar controller geared for maximum customizability."
  s.homepage         = "https://github.com/chakrit/oztabbarcontroller"
  s.license          = 'BSD'
  s.author           = { "Chakrit Wichian" => "service@chakrit.net" }
  s.source           = {
    :git => "https://github.com/chakrit/oztabbarcontroller.git",
    :tag => "v0.2.2"
  }

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'OZTabBarController/**/*.{h,m}'
  s.frameworks   = 'Foundation', 'UIKit'
end
