platform :ios, '9.0'

target 'CWWeChat' do

  use_frameworks!
  inhibit_all_warnings!

  # Pods for CWWeChat  
  # layout
  pod 'SnapKit'

  # request
  pod 'OHHTTPStubs/Swift'

  pod 'YYText'
  pod 'SwiftyImage'
  pod 'Kingfisher'

  pod 'SQLite.swift'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
      
# log
  pod 'SwiftyBeaver'
  
  # chat
  pod 'XMPPFramework', :git => 'https://github.com/robbiehanson/XMPPFramework.git', :branch => 'master'
  
  # UI
  pod 'PPBadgeViewSwift'
  pod 'MBProgressHUD'
 
  pod 'CWActionSheet'
  pod 'CWShareView'

  pod 'FSPagerView'
  
  # tool
  pod 'Hue'
  pod 'SwiftyJSON'
  pod 'KVOController'
  
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



post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'Quick' || target.name == 'Nimble'
            print "Changing Quick swift version to 3.2\n"
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
end


