import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grace_day/model/GraceDay.dart';
import 'package:grace_day/page/CreateGrace.dart';

///自定义卡片组件
class GraceCard extends StatefulWidget {

  final GraceDay graceDay;

  GraceCard({Key key, @required this.graceDay}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GraceCardState();
  }
}

class _GraceCardState extends State<GraceCard> {

  MaterialColor cardBgColor(color) {
    MaterialColor _color = Colors.red;
    switch(color) {
      case 0:
        _color = Colors.green;
        break;
      case 1:
        _color = Colors.red;
        break;
      case 2:
        _color = Colors.orange;
        break;
      case 3:
        _color = Colors.teal;
        break;
      case 4:
        _color = Colors.blue;
        break;
      case 5:
        _color = Colors.pink;
        break;
      case 6:
        _color = Colors.purple;
        break;
    }
    return _color;
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = (size.width - 48) / 2;

    BoxDecoration boxDecoration1 = BoxDecoration(
      shape: BoxShape.rectangle, // 默认值也是矩形
      borderRadius: new BorderRadius.circular((11.0)),
      color: cardBgColor(widget.graceDay.color),
      boxShadow: [
        BoxShadow(
          color: cardBgColor(widget.graceDay.color),
          offset: Offset(2.0, 5.0),
          blurRadius: 20.0,
          spreadRadius: -3.0
        )
      ],
    );

    BoxDecoration boxDecoration2 = BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular((11.0)),
      image: DecorationImage(image: AssetImage(widget.graceDay.imgUrl), fit: BoxFit.fill),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey,
          offset: Offset(2.0, 5.0),
          blurRadius: 20.0,
          spreadRadius: -3.0
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
        decoration: widget.graceDay.bgType == 0 ? boxDecoration1 : boxDecoration2,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.graceDay.content,
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'fz',
                    fontSize: 18.0
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.graceDay.remark,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'fz',
                    fontSize: 16.0
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 22.0),
                child: Text(
                  '剩',
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'fz',
                    fontSize: 16.0
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text(
                      '${dayNums()}',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'fz',
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      '天',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'fz',
                        fontSize: 16.0
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text(
                      widget.graceDay.time,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'fz',
                        fontSize: 16.0
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateGrace(graceDay: widget.graceDay))),
    );
  }

  int dayNums() {
    var _dateTime = DateTime.parse(widget.graceDay.time);
    int t1 = _dateTime.millisecondsSinceEpoch;
    int t2 = DateTime.now().millisecondsSinceEpoch;
    if (t1 > t2) {
      return ((t1 - t2) ~/ (24 * 3600 * 1000)) + 1;
    } else {
      return 0;
    }
  }

}