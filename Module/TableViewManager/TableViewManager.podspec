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

  s.name         = "TableViewManager"
  s.version      = "0.0.1"
  s.summary      = "tableView Manager"

  s.description  = <<-DESC
                     tableView Manager
                   DESC

  s.homepage     = "https://github.com/cwwise/TableViewManager"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "ios_chenwei" => "wei18810109052@163.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/cwwise/TableViewManager.git", :tag => "#{s.version}" }

  s.source_files  = "Sources", "Sources/**/*.{h,swift}"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  s.framework  = "UIKit"
    
  s.dependency "Hue"
  s.dependency "SnapKit"

end
