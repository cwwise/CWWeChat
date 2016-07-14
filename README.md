![image](https://github.com/wei18810109052/CWWeChat/blob/master/source/Images/CWWeChatIcon.png)
## CWWeChat
[![License](https://img.shields.io/packagist/l/doctrine/orm.svg)](https://github.com/wei18810109052/CWWeChat/blob/master/LICENSE)
[![Swift2.3](https://img.shields.io/badge/Swift-2.2-blue.svg?style=flat)](https://developer.apple.com/swift/)


* 2016.6开始，仿做一个微信，将持续更新直至完成。swift版本，集成XMPP聊天。
* 如果你喜欢，欢迎Star、Fork!

##目录
- [运行说明](#运行说明)
- [更新日志](#更新日志)
- [截图](#GIF)
  - [UI部分](#UI部分)
  - [IM部分](#IM部分)
- [Bug反馈](#Bug反馈)
- [联系我](#联系我) 

##<a id="运行说明"></a>运行说明
运行环境Xcode7.3 iOS8以上，使用swift2.2，swift3将在项目大体完成后，进行改进。
项目使用cocoaPod管理，下载之后运行pod install

运行前需要安装[ejabberd](https://www.process-one.net/en/ejabberd/downloads/),可以按照我写的简易[教材](https://github.com/wei18810109052/CWWeChat/wiki/XMPP%E6%9C%8D%E5%8A%A1%E5%99%A8%E6%90%AD%E5%BB%BA)安装。
安装好之后，可以查看[脚本文件](https://github.com/wei18810109052/CWWeChat/blob/master/scripts/createuser.sh)，注册用户,便于测试。

<!--##<a id="功能说明"></a>功能说明
* 实现XMPP发送文本消息，图片和语音消息。
* 好友列表-->

##<a id="更新日志"></a>更新日志
* 2016.7.10  添加聊天界面显示时间的逻辑，开始完善聊天界面键盘部分。
* 2016.7.6  修改消息存储结构，便于拓展，完成图片发送和显示的逻辑。
* 2016.7.4  完成会话界面，显示未读数量的逻辑。
* 2016.7.3  添加七牛图片存储部分，待完成图片发送部分。
* 2016.6.28 完成xmpp聊天部分，发送，存储，显示的流程
* 2016.6.26 对消息部分整理和消息发送界面简单实现
* 2016.6.25 添加xmpp逻辑处理以及xmpp服务器搭建教程
* 2016.6.24 完成通讯录界面和一部分我的设置界面
* 2016.6.23 开始仿写微信项目，完成主体界面的基本布局

##<a id="GIF"></a>截图
###<a id="UI部分"></a>UI部分
 ![image](https://github.com/wei18810109052/CWWeChat/blob/master/source/Images/Simulator_Message_2.png)

 ![image](https://github.com/wei18810109052/CWWeChat/blob/master/source/Images/Simulator_Address_2.png)
 
 ![image](https://github.com/wei18810109052/CWWeChat/blob/master/source/Images/Simulator_Discover_2.png)
 
 ![image](https://github.com/wei18810109052/CWWeChat/blob/master/source/Images/Simulator_Mine_2.png)

##<a id="Bug反馈"></a>Bug反馈
[Bug反馈](https://github.com/wei18810109052/CWWeChat/issues)

##<a id="联系我"></a>联系我
如果你有建议欢迎发邮件至email: wei18810109052@163.com

##参考和感谢
[WWeChat](https://github.com/Wzxhaha/WWeChat)
[TLChat](https://github.com/tbl00c/TLChat)

