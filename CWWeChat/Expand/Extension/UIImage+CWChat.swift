//
//  UIImage+CWChat.swift
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


import Foundation
import UIKit

typealias CWAsset = UIImage.Asset

extension UIImage {
    enum Asset: String {
        case Default_company_head = "default_company_head"
        case Default_head = "default_head"
        case Nav_back = "nav_back"
        case Nav_more = "nav_more"
        case SearchBar_voice = "searchBar_voice"
        case SearchBar_voice_HL = "searchBar_voice_HL"
        case Discover_album = "discover_album"
        case Discover_bottle = "discover_bottle"
        case Discover_game = "discover_game"
        case Discover_location = "discover_location"
        case Discover_QRcode = "discover_QRcode"
        case Discover_shake = "discover_shake"
        case Discover_shopping = "discover_shopping"
        case FootStep = "FootStep"
        case Nav_shopping_menu = "nav_shopping_menu"
        case Message_receiver_bg = "message_receiver_bg"
        case Message_receiver_bgHL = "message_receiver_bgHL"
        case Message_sender_bg = "message_sender_bg"
        case Message_sender_bgHL = "message_sender_bgHL"
        case Mine_album = "mine_album"
        case Mine_card = "mine_card"
        case Mine_cell_myQR = "mine_cell_myQR"
        case Mine_expression = "mine_expression"
        case Mine_favorites = "mine_favorites"
        case Mine_setting = "mine_setting"
        case Mine_wallet = "mine_wallet"
        case Nav_setting = "nav_setting"
        case Setting_lockoff = "setting_lockoff"
        case Setting_lockon = "setting_lockon"
        case Tabbar_badge = "tabbar_badge"
        case Tabbar_contacts = "tabbar_contacts"
        case Tabbar_contactsHL = "tabbar_contactsHL"
        case Tabbar_discover = "tabbar_discover"
        case Tabbar_discoverHL = "tabbar_discoverHL"
        case Tabbar_mainframe = "tabbar_mainframe"
        case Tabbar_mainframeHL = "tabbar_mainframeHL"
        case Tabbar_me = "tabbar_me"
        case Tabbar_meHL = "tabbar_meHL"
        case TabbarBkg = "tabbarBkg"
        
        var image: UIImage {
            return UIImage(asset: self)
        }
    }
    
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}
