import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grace_day/bloc/BlocProvider.dart';
import 'package:grace_day/bloc/GraceCardBLoC.dart';
import 'package:grace_day/model/GraceDay.dart';
import 'package:grace_day/page/SelectBgImage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grace_day/widget/CustomDialog.dart';

///创建日程记录卡片
class CreateGrace extends StatefulWidget {

  final GraceDay graceDay;

  CreateGrace({Key key, @required this.graceDay}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreateGraceState();
  }
}

class _CreateGraceState extends State<CreateGrace> {

  var _content = '';
  var _remark = '';

  var selectColor = 0; //选中的颜色
  var selectImgUrl = ''; //选中的背景图片
  var isShowImg = false; //是否已选中图片背景

  var isShowDelBtn = true; //是否显示删除按钮

  var _dateTime = DateTime.now(); // 要做个初始化，不然后面不能传入null
  TextEditingController _controller;
  TextEditingController _controllerRemark;
  @override
  void initState() {
    super.initState();
    if (widget.graceDay != null) {
      _content = widget.graceDay.content;
      _remark = widget.graceDay.remark;
      selectColor = widget.graceDay.color;
      selectImgUrl = widget.graceDay.imgUrl;
      isShowDelBtn = false;
      _dateTime = DateTime.parse(widget.graceDay.time);
      if (widget.graceDay.bgType == 1) {
        isShowImg = true;
        selectColor = -1;
      } else {
        isShowImg = false;
      }
    }
    _controller = TextEditingController.fromValue(TextEditingValue(text: _content));
    _controllerRemark = TextEditingController.fromValue(TextEditingValue(text: _remark));
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    final cardBLoC = BlocProvider.of<GraceCardBLoC>(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;

    ConstrainedBox _contentBox = ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: width
      ),
      child: new TextField(
        controller: _controller,
        autofocus: false,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 15.0),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12.0),
          hintText: "点击这里输入记录事件",
          border: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none
          ),
          filled: true,
          fillColor: Color(0xFFFFFFFF),
        ),
        onChanged: (text) {
          setState(() {
            _content = text.trim();
          });
        },
      ),
    );

    Container _container1 = Container(
      padding: EdgeInsets.all(12.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Icon(Icons.access_time, color: Colors.grey[600]),
          SizedBox(
            width: 12.0,
          ),
          Text('目标日'),
          SizedBox(
            width: 32.0,
          ),
          GestureDetector(
            child: Text(_dateTime.toString().substring(0, 'yyyy-MM-dd'.length)),
            onTap: () => {
              _showDatePicker()
            },
          )
        ],
      ),
    );

    ConstrainedBox _remarkBox = ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: width
      ),
      child: new TextField(
        controller: _controllerRemark,
        autofocus: false,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 15.0),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12.0),
          hintText: "备注(可选)",
          prefixIcon: Icon(Icons.book),
          border: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none
          ),
          filled: true,
          fillColor: Color(0xFFFFFFFF),
        ),
        onChanged: (text) {
          setState(() {
            _remark = text.trim();
          });
        },
      ),
    );

    Container _container2 = Container(
      padding: EdgeInsets.all(12.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Offstage(
                  offstage: !(selectColor == 0),
                  child: CircleAvatar(
                    backgroundColor: Colors.green[200],
                    radius: 15.0,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 12.0,
                ),
              ],
            ),
            onTap: () => {
              selectCardColor(0)
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Offstage(
                  offstage: !(selectColor == 1),
                  child: CircleAvatar(
                    backgroundColor: Colors.red[200],
                    radius: 15.0,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 12.0,
                ),
              ],
            ),
            onTap: () => {
              selectCardColor(1)
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Offstage(
                  offstage: !(selectColor == 2),
                  child: CircleAvatar(
                    backgroundColor: Colors.orange[200],
                    radius: 15.0,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 12.0,
                ),
              ],
            ),
            onTap: () => {
              selectCardColor(2)
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Offstage(
                  offstage: !(selectColor == 3),
                  child: CircleAvatar(
                    backgroundColor: Colors.teal[200],
                    radius: 15.0,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 12.0,
                ),
              ],
            ),
            onTap: () => {
              selectCardColor(3)
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Offstage(
                  offstage: !(selectColor == 4),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[200],
                    radius: 15.0,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 12.0,
                ),
              ],
            ),
            onTap: () => {
              selectCardColor(4)
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Offstage(
                  offstage: !(selectColor == 5),
                  child: CircleAvatar(
                    backgroundColor: Colors.pink[200],
                    radius: 15.0,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.pink,
                  radius: 12.0,
                ),
              ],
            ),
            onTap: () => {
              selectCardColor(5)
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Offstage(
                  offstage: !(selectColor == 6),
                  child: CircleAvatar(
                    backgroundColor: Colors.purple[300],
                    radius: 15.0,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 12.0,
                ),
              ],
            ),
            onTap: () => {
              selectCardColor(6)
            },
          ),
        ],
      ),
    );

    Container _container3 = Container(
      padding: EdgeInsets.all(12.0),
      color: Colors.white,
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Text('图片背景'),
            Expanded(
              child: Text(''),
              flex: 1,
            ),
            Offstage(
              offstage: !isShowImg,
              child: Text('已选', style: TextStyle(color: Theme.of(context).primaryColor)),
            ),
            Icon(Icons.chevron_right)
          ],
        ),
        onTap: () => {
          pushSelectImg()
        },
      ),
    );

    Container _container4 = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 12.0, right: 12.0),
      child: Row(
        children: <Widget>[
          Offstage(
            offstage: isShowDelBtn,
            child: OutlineButton(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              child: new Text('删除',style: new TextStyle(color: Theme.of(context).primaryColor),),
              onPressed: () {
                deleteHint(cardBLoC);
              },
            ),
          ),
          Expanded(
            child: Text(''),
            flex: 1,
          ),
          FlatButton(
            onPressed: () => {
              updateOrAdd(cardBLoC)
            },
            color: Theme.of(context).primaryColor,
            child: Container(
              width: 70,
              height: 42.0,
              child: Center(
                child: Text('保存', style: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          )
        ],
      ),
    );

    Column _column = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 32.0,
        ),
        _contentBox,
        SizedBox(
          height: 32.0,
        ),
        _container1,
        SizedBox(
          height: 32.0,
        ),
        _remarkBox,
        SizedBox(
          height: 32.0,
        ),
        _container2,
        SizedBox(
          height: 32.0,
        ),
        _container3,
        SizedBox(
          height: 32.0,
        ),
        _container4
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '创建时光Lite',
          textScaleFactor: 1.3,
          style: TextStyle(
              fontFamily: 'fz',
              fontSize: 18.0
          ),
        ),
        elevation: 0.5,
        centerTitle: true,
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: _column,
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectCardColor(int index) {
    selectImgUrl = '';
    isShowImg = false;
    selectColor = index;
    setState(() {
    });
  }

  void pushSelectImg() async {
    final url = await Navigator.push(context,
        new MaterialPageRoute(builder: (context) {
          return SelectBgImage(selectImage: selectImgUrl);
        })
    );

    if(url != null && url.toString().length != 0) {
      selectImgUrl = url;
      isShowImg = true;
      selectColor = -1;
      setState(() {
      });
    }
  }

  void _showDatePicker() {
    _selectDate(context);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime _picked = await showDatePicker(
      context: context,
      initialDate: _dateTime, // 不能传入null
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2056),
    );

    if (_picked != null) {
      print(_picked);
      setState(() {
        _dateTime = _picked;
      });
    }
  }

  void updateOrAdd(GraceCardBLoC bloc) {
    _content = _controller.text.trim();
    if(_content == null || _content.length == 0) {
      showToast('先写一个目标事件吧');
      return;
    }
    _remark = _controllerRemark.text.trim();
    if(_remark == null) {
      _remark = '';
    }
    var _time = _dateTime.toString().substring(0, 'yyyy-MM-dd'.length);
    var _bgType = 0;
    if (selectImgUrl == null || selectImgUrl.length == 0) {
      _bgType = 0;
    } else {
      _bgType = 1;
      selectColor = -1;
    }

    if (widget.graceDay != null) {
      var id = widget.graceDay.id;
      GraceDay todo = GraceDay(id, _content, _remark, _time, _bgType, selectColor, selectImgUrl);
      bloc.updateCardDB(todo);
    } else {
      var id = DateTime.now().millisecondsSinceEpoch;
      GraceDay todo = GraceDay(id, _content, _remark, _time, _bgType, selectColor, selectImgUrl);
      bloc.saveCardDB(todo);
    }
    Navigator.pop(context);
  }

  void deleteHint(GraceCardBLoC cardBLoC) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return CustomDialog(
          content: '确定删除吗？',
          outsideDismiss: false,
          confirmTextColor: Theme.of(context).primaryColor,
          confirmCallback: () async {
            cardBLoC.deleteCardDB(widget.graceDay);
            Navigator.pop(context);
          },
        );
      }
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}