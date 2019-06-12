import 'dart:convert';
import 'dart:ui';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grace_day/page/GraceShow.dart';
import 'package:grace_day/page/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {

  var _phone = '';
  var _password = '';

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future checkToken() async {
    //是否已登录过
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String objectId = prefs.getString('objectId');

    if(objectId != null && objectId.length > 0) {
      Navigator.pushAndRemoveUntil(context,
        new MaterialPageRoute(builder: (context) {
          return GraceShow();
        }
      ), (route) => route == null);
    }
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
        Text('欢迎登录时光Lite', style: TextStyle(fontSize: 23.0, fontFamily: 'fz', color: Colors.black54))
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

    Container _container = Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: _login,
            color: Colors.blue[400],
            child: Container(
              width: width - 120,
              height: 42.0,
              child: Center(
                child: Text('登录', style: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          )
        ],
      ),
    );

    Container _container1 = Container(
      alignment: Alignment.center,
      width: width - 120,
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Text('注册', style: TextStyle(color: Colors.black38, fontSize: 16.0)),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register())),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Text('忘记密码', style: TextStyle(color: Colors.black38, fontSize: 16.0)),
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
          height: 54.0,
        ),
        _container,
        SizedBox(
          height: 3.0,
        ),
        _container1
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

  ///用户名和密码登录
  _login() {

    if(_phone == null || _phone.length != 11) {
      showToast('请正确填写手机号');
      return;
    }
    if(_password == null || _password.length < 6 || _password.length > 14) {
      showToast('请输入密码');
      return;
    }
    var bytes = utf8.encode(_password); // 密码加密
    var _pwd = sha1.convert(bytes);

    BmobUser bmobUserLogin = BmobUser();
    bmobUserLogin.username = _phone;
    bmobUserLogin.password = _pwd.toString();
    bmobUserLogin.login().then((BmobUser bmobUser) {
      if(bmobUser.objectId != null) {
        showToast('登录成功');
        _goToHomePage(bmobUser.objectId);
      }
    }).catchError((e) {
      showToast('登录失败');
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