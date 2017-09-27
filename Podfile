platform :ios, '9.0'

target 'CWWeChat' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
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

  pod 'SQLite.swift', git: 'https://github.com/stephencelis/SQLite.swift.git' , branch: 'swift-4'
  pod 'RxSwift', git: 'https://github.com/ReactiveX/RxSwift.git', branch: 'rxswift4.0-swift4.0'
  pod 'RxCocoa', git: 'https://github.com/ReactiveX/RxSwift.git', branch: 'rxswift4.0-swift4.0'

  pod 'Alamofire'
      
# log
  pod 'SwiftyBeaver'
  
  # chat
  pod 'XMPPFramework'
  
  # UI
  pod 'PPBadgeViewSwift'
  pod 'MBProgressHUD'
 
  pod 'CWActionSheet'
  pod 'CWShareView'

  # 表情
  pod 'FSPagerView'
  
  # animation
  pod 'pop'
  
  # tool
  pod 'Hue'
  pod 'SwiftyJSON'
  pod 'KVOController'
    
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
