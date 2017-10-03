#
#  Be sure to run `pod spec lint EFTableViewManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "ChatKit"
  s.version      = "0.0.1"
  s.summary      = "ChatKit聊天部分"

  s.description  = <<-DESC
                    ChatKit聊天部分
                   DESC

  s.homepage     = "https://github.com/cwwise/ChatKit"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "ios_chenwei" => "wei18810109052@163.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/cwwise/ChatKit.git", :tag => "#{s.version}" }

  s.source_files  = "Sources", "Sources/**/*.{h,swift}"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  s.framework  = "UIKit"
  s.weak_framework = 'ChatClient'
  
  s.dependency "Kingfisher"
  s.dependency "SQLite.swift"
  s.dependency "SwiftyJSON"
    
  s.dependency "Alamofire"
  s.dependency "SwiftyBeaver"
  s.dependency "SnapKit"
  s.dependency "Hue"

end
