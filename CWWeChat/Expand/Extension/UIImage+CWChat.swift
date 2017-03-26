//
//  UIImage+Extension.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

/*
 https://github.com/AliSoftware/SwiftGen 在电脑上安装这个工具，自动生成 Asset 的 image enum 的 Extension
 切换到xcassets所在的文件夹
 命令：swiftgen images path
 */

typealias CWAsset = Asset

#if os(iOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

enum Asset: String {
  case FootStep = "FootStep"
  case Default_head = "default_head"
  case Discover_QRcode = "discover_QRcode"
  case Discover_album = "discover_album"
  case Discover_bottle = "discover_bottle"
  case Discover_game = "discover_game"
  case Discover_location = "discover_location"
  case Discover_shake = "discover_shake"
  case Discover_shopping = "discover_shopping"
  case Mine_album = "mine_album"
  case Mine_card = "mine_card"
  case Mine_cell_myQR = "mine_cell_myQR"
  case Mine_expression = "mine_expression"
  case Mine_favorites = "mine_favorites"
  case Mine_setting = "mine_setting"
  case Mine_wallet = "mine_wallet"
  case Nav_back = "nav_back"
  case Nav_more = "nav_more"
  case Nav_setting = "nav_setting"
  case SearchBar_voice = "searchBar_voice"
  case SearchBar_voice_HL = "searchBar_voice_HL"
  case Tabbar_contacts = "tabbar_contacts"
  case Tabbar_contactsHL = "tabbar_contactsHL"
  case Tabbar_discover = "tabbar_discover"
  case Tabbar_discoverHL = "tabbar_discoverHL"
  case Tabbar_mainframe = "tabbar_mainframe"
  case Tabbar_mainframeHL = "tabbar_mainframeHL"
  case Tabbar_me = "tabbar_me"
  case Tabbar_meHL = "tabbar_meHL"

  var image: Image {
    return Image(asset: self)
  }
}

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
