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

  s.name         = "ChatClient"
  s.version      = "0.0.1"
  s.summary      = "ChatClient 管理xmpp"

  s.description  = <<-DESC
                    ChatClient封装XMPP
                   DESC

  s.homepage     = "https://github.com/cwwise/ChatClient"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "ios_chenwei" => "wei18810109052@163.com" }

  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/cwwise/ChatClient.git", :tag => "#{s.version}" }

  s.source_files  = "Sources", "Sources/**/*.{h,swift}"


  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  s.framework  = "Foundation"
  s.dependency "XMPPFramework"
  s.dependency "SQLite.swift"
  s.dependency "SQLiteMigrationManager.swift"
  s.dependency "SwiftyJSON"
  s.dependency "Moya"
  s.dependency "SwiftyBeaver"

end
