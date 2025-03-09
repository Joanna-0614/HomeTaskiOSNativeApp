# HomeTaskiOSNativeApp
- 请查看[演示视频](./HomeTask/dem_720p.mov)

## 特性
- 用户认证：支持用户名和密码登录，同时提供生物识别认证（如 Touch ID 或 Face ID）功能。
- 仓库搜索：允许用户输入关键词搜索 GitHub 上的仓库，并展示搜索结果。
- 新闻资讯：从 GitHub 博客获取最新的新闻资讯，并以卡片形式展示4个。
- 用户信息管理：用户登录后可以更换头像图片。

## 技术相关
- 使用swiftUI
- 支持dark/light mode, 支持横竖屏
- 使用 MVVM 模式
- 使用 Protocol - Oriented Design 实现了搜索功能的网络请求
- 针对主要的ViewModel的单元测试
- 引入了4个第三方库：Alamofire用于网络请求，LocalAuthentication用于事物识别，KeychainAccess用于密钥管理，FeedKit用于RSS解析。

## 缺失的特性和解释
- 由于真实的github的login功能比较复杂，我暂时使用了其他可访问成功的url进行网络请求，模拟为login请求。测试login能成功的用户名为Test，密码为Password。
- 最低iOS版本 - 16.0: 这是我的Xcode支持的最低版本
- 没有发布testflight: 我的开发者账号目前无法发布testflight
- 没有提供可安装包，如果需要测试，只能从源代码编译和安装
- 没有写UI automation
