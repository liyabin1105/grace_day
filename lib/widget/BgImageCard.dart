import 'package:flutter/material.dart';
import 'package:grace_day/notify/SelectImgNotification.dart';

///图片背景
class BgImageCard extends StatelessWidget {

  final String imgUrl;
  final bool isSelect;

  BgImageCard({Key key, @required this.imgUrl, @required this.isSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = (size.width - 48) / 2;

    BoxDecoration boxDecoration = BoxDecoration(
      shape: BoxShape.rectangle, // 默认值也是矩形
      borderRadius: new BorderRadius.circular((11.0)),
      image:  DecorationImage(image: AssetImage(this.imgUrl), fit: BoxFit.fill),
      boxShadow: [
        BoxShadow(
            color: Colors.blueGrey,
            offset: Offset(2.0, 5.0),
            blurRadius: 20.0,
            spreadRadius: 0.0
        )
      ],
    );

    return GestureDetector(
      child: Container(
        constraints: BoxConstraints.expand(
            height:width * 3 / 2,
            width: width
        ),
        //设置背景图片
        decoration: boxDecoration,
        child: Container(
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(top: 16.0, right: 16.0),
          child: Offstage(
            offstage: !this.isSelect,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 18.0,
                ),
                Icon(Icons.check, color: Colors.white)
              ],
            ),
          ),
        ),
      ),
      onTap: () => {
        SelectImgNotification(this.imgUrl).dispatch(context)
      },
    );
  }

}