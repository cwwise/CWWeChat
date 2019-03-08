platform :ios, '10.0'

target 'CWWeChat' do

  use_frameworks!
  inhibit_all_warnings!

  # Pods for CWWeChat  
  # layout
  pod 'SnapKit'

  # request
  pod 'YYText'
  pod 'SwiftyImage'
  pod 'Kingfisher'

  pod 'SQLiteMigrationManager.swift'
  pod 'SQLite.swift'
  pod 'RxSwift'
  pod 'RxCocoa'

  pod 'Moya/RxSwift'
# log
  pod 'SwiftyBeaver'
  
  # chat
  pod 'XMPPFramework/Swift'

  # UI
  pod 'MBProgressHUD'
 
  pod 'CWActionSheet'
  pod 'CWShareView'

  pod 'FSPagerView'
  
  # tool
  pod 'Hue'
  pod 'SwiftyJSON'
  pod 'KVOController'
  
  pod 'SwiftDate'
#  pod 'SwiftLint'

  pod 'SwiftGen'

  # 本地pod
  pod 'TableViewManager', :path => './Module/TableViewManager/TableViewManager.podspec'
  pod 'ChatClient', :path => './Module/ChatClient/ChatClient.podspec'
  pod 'ChatKit', :path => './Module/ChatKit/ChatKit.podspec'
  pod 'MomentKit', :path => './Module/MomentKit/MomentKit.podspec'

  target 'CWWeChatTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
  end

end


