platform :ios, '9.0'

target 'CWWeChat' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # ignore cocoapod warnings
  inhibit_all_warnings!

  # Pods for CWWeChat  
  # layout
  pod 'SnapKit'
  
  # request
  pod 'Moya/RxSwift'
  pod 'RxCocoa'
  pod 'OHHTTPStubs/Swift'

  pod 'YYText'
  pod 'YYWebImage'

  pod 'SQLite.swift', :git => 'https://github.com/stephencelis/SQLite.swift' , :branch => 'swift-4'
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire' , :branch => 'swift4'
  pod 'RxSwift', :git=> 'https://github.com/ReactiveX/RxSwift', :branch => 'swift4.0'
      
# log
  pod 'SwiftyBeaver'

  # chat
  pod 'XMPPFramework'
  
  # UI
  pod 'MBProgressHUD'
  pod 'CHIPageControl/Aleppo'
  pod 'LCActionSheet'
  
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

  target 'CWWeChatUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
