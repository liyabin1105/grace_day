import 'dart:convert';
import 'dart:ui';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grace_day/page/GraceShow.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {

  var _phone = '';
  var _password = '';
  var _agintPassword = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size =MediaQuery.of(context).size;
    final width =size.width;

    Row _row1 = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
            width: 56.0,
            height: 56.0,
            image: AssetImage('./images/login_logo.png')
        ),
        SizedBox(
          width: 5.0,
        ),
        Text('欢迎注册时光Lite', style: TextStyle(fontSize: 23.0, fontFamily: 'fz', color: Colors.black54))
      ],
    );

    ConstrainedBox _inputPhone = ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: width - 90
      ),
      child: new TextField(
        autofocus: false,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 15.0),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12.0),
          hintText: "请输入手机号",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none
          ),
          filled: true,
          fillColor: Color(0xFFFFFFFF),
        ),
        onChanged: (text) {
          setState(() {
            _phone = text.trim();
          });
        },
      ),
    );

    ConstrainedBox _inputPassword = ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: width - 90
      ),
      child: new TextField(
        autofocus: false,
        obscureText: true,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 15.0),
        textInputAction: TextInputAction.done,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12.0),
          hintText: "请输入密码",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none
          ),
          filled: true,
          fillColor: Color(0xFFFFFFFF),
        ),
        onChanged: (text) {
          setState(() {
            _password = text.trim();
          });
        },
      ),
    );

    ConstrainedBox _confirmPassword = ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: width - 90
      ),
      child: new TextField(
        autofocus: false,
        obscureText: true,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 15.0),
        textInputAction: TextInputAction.done,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12.0),
          hintText: "请再次输入密码",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none
          ),
          filled: true,
          fillColor: Color(0xFFFFFFFF),
        ),
        onChanged: (text) {
          setState(() {
            _agintPassword = text.trim();
          });
        },
      ),
    );

    Container _container = Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: _queryRegister,
            color: Colors.blue[400],
            child: Container(
              width: width - 120,
              height: 42.0,
              child: Center(
                child: Text('注册', style: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          )
        ],
      ),
    );

    Column _column = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 72.0,
        ),
        _row1,
        SizedBox(
          height: 72.0,
        ),
        _inputPhone,
        SizedBox(
          height: 20.0,
        ),
        _inputPassword,
        SizedBox(
          height: 20.0,
        ),
        _confirmPassword,
        SizedBox(
          height: 54.0,
        ),
        _container,
      ],
    );

    return Scaffold(
      body: Scaffold(
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            fit: StackFit.expand,
            alignment:Alignment.center,
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: _column,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  _queryRegister() {
    if(_phone == null || _phone.length != 11) {
      showToast('请正确填写手机号');
      return;
    }
    if(_password == null || _password.length < 6 || _password.length > 14) {
      showToast('请输入密码');
      return;
    }
    if(_agintPassword == null || (_agintPassword != _password)) {
      showToast('密码不一致');
      return;
    }

    BmobQuery<BmobUser> query = BmobQuery();
    query.addWhereNotEqualTo("username", _phone);
    query.queryObjects().then((data) {
      List<BmobUser> ls = data.map((i) => BmobUser.fromJson(i)).toList();
      if(ls != null && ls.length > 0) {
        showToast('已经注册，请直接登录');
      } else {
        _register();
      }
    }).catchError((e) {
      _register();
    });


  }

  void _register() {
    var bytes = utf8.encode(_password); // 密码加密
    var _pwd = sha1.convert(bytes);
    BmobUser bmobUserRegister = BmobUser();
    bmobUserRegister.username = _phone;
    bmobUserRegister.password = _pwd.toString();
    bmobUserRegister.mobilePhoneNumber = _phone;
    bmobUserRegister.register().then((BmobRegistered data) {
      if(data.objectId != null) {
        showToast('注册成功');
        _goToHomePage(data.objectId);
      }
    }).catchError((e) {
      showToast('注册失败');
    });
  }

  void _goToHomePage(String objectId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('objectId', objectId);
    Navigator.pushAndRemoveUntil(context,
      new MaterialPageRoute(builder: (context) {
        return GraceShow();
      }
    ), (route) => route == null);
  }

}