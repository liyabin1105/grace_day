import 'package:flutter/material.dart';
import 'package:grace_day/widget/BgImageCard.dart';

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

  @override
  Widget build(BuildContext context) {

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