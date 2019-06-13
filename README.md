# 时光Lite

项目的状态管理是BLoC+RxDart，包括主题换肤、数据刷新渲染；项目前期使用了sqflite创建本地数据库存储数据，目前已经迁移到Bmob云数据库中，同时增加了登录注册功能。

## 效果图
![screenshot](./screenshot/s1.png) ![screenshot](./screenshot/s2.png)
![screenshot](./screenshot/s3.png) ![screenshot](./screenshot/s4.png)

## apk下载地址：
https://www.pgyer.com/grace_day

![screenshot](./screenshot/download.png)

## 功能
-  登录注册
-  首页展示
-  创建卡片
-  背景图片
-  拍照相册
-  主题换肤

## 第三方框架
|库|说明
|---|---
|shared_preferences|本地数据缓存
|image_picker|拍照以及相册选图
|data_plugin|Bmob云数据库
|fluttertoast|Toast提示
|rxdart|配合BLoC全局状态管理
|sqflite|本地数据库(已迁移到Bmob)


## 鸣谢
APP的UI设计参考了FancyDays和小程序倒数日Air的UI风格。Logo则是在阿里Iconfont上找的。

