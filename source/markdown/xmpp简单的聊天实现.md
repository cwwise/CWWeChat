##XMPP简单的聊天实现

###配置xmpp
* 直接使用`cocoaPod`来安装最方便。在`Podfile`中添加`pod 'XMPPFramework'`

* 手动配置可以查看官方连接[官方链接](https://github.com/robbiehanson/XMPPFramework/wiki/GettingStarted_iOS)

###连接xmpp

连接xmpp，需要创建`xmppStream`对象,并设置代理

```swift
let queue = dispatch_queue_create("com.cwxmppchat.cwcoder", DISPATCH_QUEUE_CONCURRENT)
xmppStream.addDelegate(self, delegateQueue: queue)
```

连接xmpp需要JID，JID由三部分组成，`user`用户名,`domain`xmpp中的域,`resource`来源，如果多端登录可以自定义

```swift
let user = "chenwei"
let domin = "chat.com"
let resource = "simulator"
xmppStream.myJID = XMPPJID.jidWithUser(user, domain: domin, resource: resource)
xmppStream.hostName = hostName
xmppStream.hostPort = hostPort
 
do {
    try xmppStream.connectWithTimeout(timeoutInterval)
} catch let error as NSError {
    print(error)
}
```

调用连接之后，会调用`XMPPStreamDelegate`的一系列方法

```
//将要连接
func xmppStreamWillConnect(sender: XMPPStream!)
```

```
//已经连接，就输入密码
func xmppStreamDidConnect(sender: XMPPStream!) {
    do {
        try xmppStream.authenticateWithPassword(password)
    } catch let error as NSError {
        print(error)
    }
}
```

```
//认证成功，之后需要让用户在线
func xmppStreamDidAuthenticate(sender: XMPPStream!)

//认证失败，会调用，error可以获取到错误的原因
func xmppStream(sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!)
```

```
//发送在线信息
func goOnline() {
    let presence = XMPPPresence(type: "available")
    xmppStream.sendElement(presence)
}
```


## XMPP消息发送和处理

###消息发送

组装消息XML体，可以直接使用`XMPPMessage`这个类直接使用，消息回执可以查看`XMPPFramework-XEP_0184`中的两个类.

```
/**
 组装XMPPMessage消息体
 
 - parameter message:   消息内容
 - parameter to:        发送到对方的JID
 - parameter messageId: 消息Id
 
 - returns: 消息XMPPMessage的实体
 */
func messageElement(body: String, to: String, messageId: String) -> XMPPMessage {
	 //生成XMPPMessage
    let message = XMPPMessage(type: "chat", elementID: messageId)
    message.addAttributeWithName("to", stringValue: to)
    //消息回执
    //message.addReceiptRequest()
    message.addBody(body)
    return XMPPMessage(fromElement: message)
}
```

生成消息的xml格式类似这种

```
<message type="chat" id="53DA0B0560284B2EB7C7E2880FD0A5440055" to="tom@chenweiim.com">
<body>Hello world</body>
</message>
```
如果生成消息时，添加`message.addReceiptRequest()`回执消息

```
<message type="chat" id="53DA0B0560284B2EB7C7E2880FD0A5440055" to="tom@chenweiim.com">
<request xmlns="urn:xmpp:receipts"/>
<body>Hello world</body>
</message>
```

发送消息，通过`xmppStream`发送消息，发送消息并不需要`from`,`xmppStream`自己会拼接上去。

```
/**
 发送消息
 
 - parameter content:   消息内容
 - parameter toId:      发送到对方的JID
 - parameter messageId: 消息Id
 
 - returns: 发送消息的结果
 */
func sendMessage(content:String, toId:String, messageId:String) -> Bool {
    let messageElement = self.messageElement(content, to: toId, messageId: messageId)
    
    var receipte: XMPPElementReceipt?
    self.xmppStream.sendElement(messageElement, andGetReceipt: &receipte)
    guard let elementReceipte = receipte else {
        return false
    }
    let result = elementReceipte.wait(sendMessageTimeoutInterval)
    return result
}

```


##消息

输入消息的时候，会有两种类型的提示消息，一种是正在输入，一种是停止输入
消息中的`from`和`to`均是消息发起者和消息的接收者

* 输入消息

```xml
/**正在输入*/
<message xmlns="jabber:client" from="jerry@chenweiim.com/weiweideMacBook-Pro" to="chenwei@chenweiim.com" type="chat" id="purple6626f295">
	<composing xmlns="http://jabber.org/protocol/chatstates"/>
</message>

/**停止输入*/
<message xmlns="jabber:client" from="jerry@chenweiim.com/weiweideMacBook-Pro" to="chenwei@chenweiim.com" type="chat" id="purple6626f296">
	<paused xmlns="http://jabber.org/protocol/chatstates"></paused>
</message>

/**实体消息*/
<message xmlns="jabber:client" from="jerry@chenweiim.com/weiweideMacBook-Pro" to="chenwei@chenweiim.com" type="chat" id="purple6626f2a9">
	<active xmlns="http://jabber.org/protocol/chatstates"/>
	<body>123</body>
</message>
```

* 离线消息
 
 离线消息也是有正在输入和停止输入的格式

```
<message xmlns="jabber:client" from="jerry@chenweiim.com/weiweideMacBook-Pro" to="chenwei@chenweiim.com" type="chat" id="purple6626f252">
	<active xmlns="http://jabber.org/protocol/chatstates"/>
	<body>12312312</body>
    <delay xmlns="urn:xmpp:delay" from="chenweiim.com" stamp="2016-05-30T02:47:28Z">
     Offline Storage
   </delay>
   <x xmlns="jabber:x:delay" stamp="20160530T02:47:28"/>
</message>   
```



##其他资料

[CocoaChina整理的资料](http://www.cocoachina.com/ios/20141219/10703.html)


##文件发送
官方链接
[XMPPFileTransfer](https://github.com/robbiehanson/XMPPFramework/blob/f9fa43e00f9669839f2b7050010d791109ebad4a/Extensions/FileTransfer/XMPPFileTransfer.h)

备注:
发送消息的Demo
[GithubDemo](https://github.com/nplexity/xmpp-file-transfer-demo/blob/master/FileTransferDemo/TransferViewController.m)

[XMPPFramework](https://github.com/robbiehanson/XMPPFramework)

