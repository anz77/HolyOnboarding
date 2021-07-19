#
#  Be sure to run `pod spec lint HolyOnboarding.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name           = "HolyOnboarding"

  spec.version        = "1.0.0"

  spec.summary        = "Producing HolyOnboarding"
  
  spec.description    = "Cocoapod for presenting onboarding flow in your iOS application"

  spec.homepage       = "https://github.com/anz77/HolyOnboarding"
  
  spec.license        = { :type => "MIT", :file => "LICENSE" }

  spec.author         = { "ANDRII ZUIOK" => "a.zuiok77@gmail.com" }
  
  spec.platform       = :ios, "13.0"

  spec.swift_version  = "5.0"

  spec.source         = { :git => "https://github.com/anz77/HolyOnboarding.git", :tag => "#{spec.version}" }

  spec.source_files   = "HolyOnboarding", "HolyOnboarding/**/*.{h,m,swift}"

  spec.framework      = "UIKit"
  
end
