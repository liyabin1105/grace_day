import 'package:flutter/material.dart';

///自定义通知，图片背景列表选中通知
class SelectImgNotification extends Notification {
  final String imgUrl;
  SelectImgNotification(this.imgUrl);
}