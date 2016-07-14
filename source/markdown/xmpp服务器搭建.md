
## XMPP服务器搭建
>XMPP服务器的种类有很多。可以查看[官方连接](https://xmpp.org/software)

在Mac上一般使用`Openfire`来搭建，但是搭建的过程比较麻烦些，还需要安装`Mysql`。我之前也是看别人的博客进行安装的。这两个链接可以看看。
[mac上安装MySQL](http://www.cnblogs.com/xiaodao/archive/2013/04/04/2999426.html)
[mac上搭建openfire服务器](http://www.cnblogs.com/xiaodao/archive/2013/04/05/3000554.html)

最近看到swiftV上的视频，学习到了另外一种傻瓜的安装方式，使用的[ejabberd](https://www.process-one.net/en/ejabberd/downloads/)来进行安装的，直接安装就可以了，无需其他设置。
安装过程中两点比较重要。
* 安装过程中，会出现设置域的画面。一般域设置类似URL那种。类似`chatimswift.com`这种。这个域后面都会用得上。
* 管理员账号密码，直接设置admin，admin比较简单一点。

安装完成之后呢，在应用程序中可以查看到安装好的ejabberd服务器。点击bin里面的start就可以启动了。需要登录管理员帐号，需要输入admin@ domain  doain就是上面设置的域。
![ejabberd-1](http://7xsvuf.com1.z0.glb.clouddn.com/2016-05-30-ejabberd-1.png)

启动之后，出现这样的画面，表示启动成功。第一次启动的时候，会让你输入账号密码，
![ejabberd-2](http://7xsvuf.com1.z0.glb.clouddn.com/2016-05-30-ejabberd-2.png)

进入之后，可以自己添加用户名密码
![ejabberd-3](http://7xsvuf.com1.z0.glb.clouddn.com/2016-05-30-ejabberd-3.png)

##客服端选择
xmppclient有很多种类，根据自己的系统选择不同的客户端，Mac系统一般选择Aduim。

##备注
XMPP的介绍，以及server和client的介绍
[XMPP官网链接](https://xmpp.org/software)
[Github链接](https://github.com/funkyboy/Building-a-Jabber-client-for-iOS)