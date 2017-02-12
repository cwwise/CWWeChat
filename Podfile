# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'CWWeChat' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CWWeChat
  #工具
  pod 'UIColor_Hex_Swift'
  pod 'SwiftyJSON'
  
  #布局
  pod 'SnapKit'
  
  #网络请求
  pod 'Alamofire'
  
  pod 'YYText'
  pod 'YYWebImage'
  #数据库
  pod 'SQLite.swift'
  
  #聊天
  pod 'XMPPFramework', :git => "https://github.com/wei18810109052/XMPPFramework.git", :branch => 'master'
  
  
  pod 'Qiniu'
  pod 'MBProgressHUD'
  
  # 本地pod
  pod 'CWTableViewManager', :path => './CWPrivatePod/CWTableViewManager'



  target 'CWWeChatTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CWWeChatUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
