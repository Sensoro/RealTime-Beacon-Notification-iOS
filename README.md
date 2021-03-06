# RealTime-Beacon-Notification-iOS
演示如何使用进出一个Beacon区域时，发送一个实时消息。

步骤:

1. 首先使用配置工具配置相关的Beacon配置信息如下

```
{
"beacon":true,
"id":"23A01AF0-232A-4518-9C0E-323FB773F5EF",
"mj":"0x8888",
"mi":"0x8888",
"tx":6,
"ai":4,
}
```

您也可以通过配置工具的扫描如下二维码配置(或将项目中的二维码保存到相册获取二维码)

 ![image](https://raw.githubusercontent.com/Sensoro/Beacon-Notification-iOS/master/Resources/Notification.JPG)
 

如果您身边没有Beacon，您也可以在手机上装一个模拟云子的App

下载链接：http://fir.im/wpko

2. 打开App，进入后台
3. 离开Beacon的区域，会有离场消息弹出（谢谢光临Sensoro）
4. 停留大概1分钟左右，然后进入到Beacon区域，会有进场消息弹出(欢迎进入Sensoro)。


注意事项：

1. 测试 IOS 设备的系统要求 7.0 以上，iPhone 4s 及以上, iPad 3 及以上,Ipod 5 及以上
2. 注意检测设备有没有开启蓝牙
3. 如果长时间得不到消息，请重启下手机
4. Region 型的通知，同时触发最多10个,不同的 Region 最多监听20个，并且和监听顺序相关
5. 复用代码时注意 info.plist 中加入Key  NSLocationAlwaysUsageDescription

