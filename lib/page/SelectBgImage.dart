import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grace_day/widget/BgImageCard.dart';
import 'package:image_picker/image_picker.dart';

///卡片图片背景选择
class SelectBgImage extends StatefulWidget {

  final String selectImage;

  SelectBgImage({Key key, @required this.selectImage}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectBgImageState();
  }
}

class _SelectBgImageState extends State<SelectBgImage> {

  List<String> imgList = [];

  @override
  void initState() {
    super.initState();
    initData();
    setState(() {
    });
  }

  void initData() {
    imgList.add('./images/f1.png');
    imgList.add('./images/f2.png');
    imgList.add('./images/f3.png');
    imgList.add('./images/f4.png');
    imgList.add('./images/f5.png');
  }

  File _image;

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    setState(() {
      _image = image;
      if(_image != null) {
        Navigator.pop(context, _image.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    PopupMenuButton pmb = PopupMenuButton<String>(
        onSelected: (String value) {
          if (value == '相机') {
            getImage(ImageSource.camera);
          } else {
            getImage(ImageSource.gallery);
          }
        },

        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('相机'),
                Icon(Icons.camera_alt, color: Theme.of(context).primaryColor)
              ],
            ),
            value: '相机',
          ),
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('相册'),
                Icon(Icons.camera, color: Theme.of(context).primaryColor)
              ],
            ),
            value: '相册',
          )
        ]);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '选择卡片背景',
            textScaleFactor: 1.3,
            style: TextStyle(
              fontFamily: 'fz',
              fontSize: 18.0
            ),
          ),
          elevation: 0.5,
          centerTitle: true,
          actions: <Widget>[
            pmb
          ]
        ),
        body: NotificationListener(
          onNotification: (notification) {
            Navigator.pop(context, notification.imgUrl);
          },
          child: Scaffold(
            body: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //每行三列
                  childAspectRatio: 2/3, //显示区域宽高相等
                  crossAxisSpacing: 16.0,
                ),
                itemCount:imgList.length,
                itemBuilder: (context, index) {
                  var isSelect = (imgList[index] == widget.selectImage);
                  return Container(
                    padding: index % 2 == 0 ? EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0) : EdgeInsets.only(right: 16.0,top: 8.0, bottom: 8.0),
                    child: BgImageCard(imgUrl: imgList[index], isSelect: isSelect),
                  );
                }
            ),
          )
        )
    );
  }

}