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
  case Friends_group = "friends_group"
  case Friends_new = "friends_new"
  case Friends_public = "friends_public"
  case Friends_tag = "friends_tag"
  case Nav_add_friend = "nav_add_friend"
  case NewFriend_contacts = "newFriend_contacts"
  case NewFriend_google = "newFriend_google"
  case NewFriend_qq = "newFriend_qq"
  case Emoji_hl_background = "emoji_hl_background"
  case Emoji_tusiji_001 = "emoji_tusiji_001"
  case EmojiKB_bigTips_left = "emojiKB_bigTips_left"
  case EmojiKB_bigTips_middle = "emojiKB_bigTips_middle"
  case EmojiKB_bigTips_right = "emojiKB_bigTips_right"
  case EmojiKB_emoji_delete = "emojiKB_emoji_delete"
  case EmojiKB_group_face = "emojiKB_group_face"
  case EmojiKB_group_tusiji = "emojiKB_group_tusiji"
  case EmojiKB_groupControl_add = "emojiKB_groupControl_add"
  case EmojiKB_sendBtn_blue = "emojiKB_sendBtn_blue"
  case EmojiKB_sendBtn_blueHL = "emojiKB_sendBtn_blueHL"
  case EmojiKB_settingBtn = "emojiKB_settingBtn"
  case EmojiKB_tips = "emojiKB_tips"
  case Nav_chat_multi = "nav_chat_multi"
  case Nav_chat_single = "nav_chat_single"
  case MessageTooShort = "MessageTooShort"
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
  case ToolViewEmotion = "ToolViewEmotion"
  case ToolViewEmotionHL = "ToolViewEmotionHL"
  case ToolViewInputVoice = "ToolViewInputVoice"
  case ToolViewInputVoiceHL = "ToolViewInputVoiceHL"
  case ToolViewKeyboard = "ToolViewKeyboard"
  case ToolViewKeyboardHL = "ToolViewKeyboardHL"
  case TypeSelectorBtn_Black = "TypeSelectorBtn_Black"
  case TypeSelectorBtnHL_Black = "TypeSelectorBtnHL_Black"
  case EmojiKB_sendBtn_gray = "emojiKB_sendBtn_gray"
  case Message_receiver_bg = "message_receiver_bg"
  case Message_receiver_bgHL = "message_receiver_bgHL"
  case Message_sender_bg = "message_sender_bg"
  case Message_sender_bgHL = "message_sender_bgHL"
  case Message_sendfaild = "message_sendfaild"
  case ReceiverVoiceNodePlaying = "ReceiverVoiceNodePlaying"
  case ReceiverVoiceNodePlaying001 = "ReceiverVoiceNodePlaying001"
  case ReceiverVoiceNodePlaying002 = "ReceiverVoiceNodePlaying002"
  case ReceiverVoiceNodePlaying003 = "ReceiverVoiceNodePlaying003"
  case SenderVoiceNodePlaying = "SenderVoiceNodePlaying"
  case SenderVoiceNodePlaying001 = "SenderVoiceNodePlaying001"
  case SenderVoiceNodePlaying002 = "SenderVoiceNodePlaying002"
  case SenderVoiceNodePlaying003 = "SenderVoiceNodePlaying003"
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
  case Button_disable = "button_disable"
  case Button_normal = "button_normal"
  case Button_select = "button_select"
  case Show_success = "show_success"

  var image: Image {
    return Image(asset: self)
  }
}

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
