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
  case Applogo = "Applogo"
  case CellBlueSelected = "CellBlueSelected"
  case CellGreySelected = "CellGreySelected"
  case CellNotSelected = "CellNotSelected"
  case CellRedSelected = "CellRedSelected"
  case CellSelected = "CellSelected"
  case FootStep = "FootStep"
  case MessageSendFail = "MessageSendFail"
  case MessageTooShort = "MessageTooShort"
  case ReceiverVoiceNodePlaying001 = "ReceiverVoiceNodePlaying001"
  case ReceiverVoiceNodePlaying002 = "ReceiverVoiceNodePlaying002"
  case ReceiverVoiceNodePlaying003 = "ReceiverVoiceNodePlaying003"
  case RecordCancel = "RecordCancel"
  case RecordingBkg = "RecordingBkg"
  case RecordingSignal001 = "RecordingSignal001"
  case RecordingSignal002 = "RecordingSignal002"
  case RecordingSignal003 = "RecordingSignal003"
  case RecordingSignal004 = "RecordingSignal004"
  case RecordingSignal005 = "RecordingSignal005"
  case RecordingSignal006 = "RecordingSignal006"
  case RecordingSignal007 = "RecordingSignal007"
  case RecordingSignal008 = "RecordingSignal008"
  case SenderVoiceNodePlaying001 = "SenderVoiceNodePlaying001"
  case SenderVoiceNodePlaying002 = "SenderVoiceNodePlaying002"
  case SenderVoiceNodePlaying003 = "SenderVoiceNodePlaying003"
  case BackBarItemImage = "backBarItemImage"
  case Button_disable = "button_disable"
  case Button_normal = "button_normal"
  case Button_select = "button_select"
  case Chat_toolbar_emotion = "chat_toolbar_emotion"
  case Chat_toolbar_emotion_HL = "chat_toolbar_emotion_HL"
  case Chat_toolbar_keyboard = "chat_toolbar_keyboard"
  case Chat_toolbar_keyboard_HL = "chat_toolbar_keyboard_HL"
  case Chat_toolbar_more = "chat_toolbar_more"
  case Chat_toolbar_more_HL = "chat_toolbar_more_HL"
  case Chat_toolbar_voice = "chat_toolbar_voice"
  case Chat_toolbar_voice_HL = "chat_toolbar_voice_HL"
  case Contact_group_chat = "contact_group_chat"
  case Contact_new_friend = "contact_new_friend"
  case Contact_official_account = "contact_official_account"
  case Contact_signature = "contact_signature"
  case Contacts_add_friend = "contacts_add_friend"
  case Default_head = "default_head"
  case Discover_QRcode = "discover_QRcode"
  case Discover_album = "discover_album"
  case Discover_bottle = "discover_bottle"
  case Discover_game = "discover_game"
  case Discover_location = "discover_location"
  case Discover_shake = "discover_shake"
  case Discover_shopping = "discover_shopping"
  case Discover_webView_setting = "discover_webView_setting"
  case Login_background = "login_background"
  case Login_logo = "login_logo"
  case Mine_album = "mine_album"
  case Mine_card = "mine_card"
  case Mine_cell_myQR = "mine_cell_myQR"
  case Mine_expression = "mine_expression"
  case Mine_favorites = "mine_favorites"
  case Mine_setting = "mine_setting"
  case Mine_wallet = "mine_wallet"
  case Nav_back = "nav_back"
  case Nav_chat_multi = "nav_chat_multi"
  case Nav_chat_single = "nav_chat_single"
  case Nav_more = "nav_more"
  case Nav_setting = "nav_setting"
  case Receiver_background_highlight = "receiver_background_highlight"
  case Receiver_background_normal = "receiver_background_normal"
  case SearchBar_voice = "searchBar_voice"
  case SearchBar_voice_HL = "searchBar_voice_HL"
  case Sender_background_highlight = "sender_background_highlight"
  case Sender_background_normal = "sender_background_normal"
  case Setting_lockoff = "setting_lockoff"
  case Setting_lockon = "setting_lockon"
  case Show_success = "show_success"
  case Tabbar_contacts = "tabbar_contacts"
  case Tabbar_contactsHL = "tabbar_contactsHL"
  case Tabbar_discover = "tabbar_discover"
  case Tabbar_discoverHL = "tabbar_discoverHL"
  case Tabbar_mainframe = "tabbar_mainframe"
  case Tabbar_mainframeHL = "tabbar_mainframeHL"
  case Tabbar_me = "tabbar_me"
  case Tabbar_meHL = "tabbar_meHL"
  case Tabbarbackground = "tabbarbackground"

  var image: Image {
    return Image(asset: self)
  }
}

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
