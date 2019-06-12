import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:data_plugin/bmob/response/bmob_updated.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grace_day/bloc/BLoCBase.dart';
import 'package:grace_day/model/GraceBean.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GraceCardBLoC extends BLoCBase {

  List<GraceBean> _list = [];

  var _subject = BehaviorSubject<List<GraceBean>>();

  Stream<List<GraceBean>> get stream => _subject.stream;
  List<GraceBean> get value => _list;

//  queryAllData() async {
//    var db = DatabaseHelper();
//    List<GraceBean> ls = await db.getAllCards();
//    if (ls != null) {
//      _list = ls;
//    }
//    _subject.sink.add(_list);
//  }

  ///查询多条数据
  queryAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String objectId = prefs.getString('objectId');

    BmobQuery<GraceBean> query = BmobQuery();
    query.setInclude("author");
    query.queryObjects().then((List<dynamic> data) {
      List<GraceBean> ls = data.map((i) => GraceBean.fromJson(i)).toList();
      _list.clear();
      if (ls != null) {
        for (var item in ls) {
          if(item != null && item.author != null) {
            if(item.author.objectId == objectId) {
              if(overdueDay(item)) {
                _list.add(item);
              }
            }
          }
        }
      }
      _subject.sink.add(_list);
    }).catchError((e) {
    });
  }

  //过滤已经过期的记录
  bool overdueDay(GraceBean item) {
    var _dateTime = DateTime.parse(item.time);
    var _nowTime = DateTime.now().toString().substring(0, 'yyyy-MM-dd'.length);
    int t1 = _dateTime.millisecondsSinceEpoch;
    int t2 = DateTime.parse(_nowTime).millisecondsSinceEpoch;
    if (t1 < t2) {
      return false;
    } else {
      if(item.bgType == 1 && (item.imgUrl == null || item.imgUrl.length == 0)) {
        item.imgUrl = './images/f3.png';
      }
      return true;
    }
  }

//  saveCardDB(GraceBean todo1) async {
//    var db = DatabaseHelper();
//    await db.saveCard(todo1);
//    queryAllData();
//  }

  ///保存一条数据
  saveSingle(String id, String content, String remark, String time, int bgType, int color, String imgUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String objectId = prefs.getString('objectId');

    BmobUser bmobUser = BmobUser();
    bmobUser.objectId = objectId;
    GraceBean bean = GraceBean();
    bean.content = content;
    bean.remark = remark;
    bean.time = time;
    bean.bgType = bgType;
    bean.color = color;
    bean.imgUrl = imgUrl;
    bean.author = bmobUser;
    bean.save().then((BmobSaved bmobSaved) {
      showToast('保存成功');
      queryAllData();
    }).catchError((e) {
      showToast('保存失败');
      queryAllData();
    });
  }

//  void updateCardDB(GraceBean todo1) async {
//    var db = DatabaseHelper();
//    await db.updateCard(todo1);
//    queryAllData();
//  }

  ///修改一条数据
  updateSingle(String id, String content, String remark, String time, int bgType, int color, String imgUrl) {
    GraceBean bean = GraceBean();
    bean.objectId = id;
    bean.content = content;
    bean.remark = remark;
    bean.time = time;
    bean.bgType = bgType;
    bean.color = color;
    bean.imgUrl = imgUrl;

    bean.update().then((BmobUpdated bmobUpdated) {
      showToast('修改成功');
      queryAllData();
    }).catchError((e) {
      showToast('修改失败');
      queryAllData();
    });
  }

//  void deleteCardDB(GraceBean todo1) async {
//    if (todo1 != null) {
//      var id = todo1.objectId;
//      var db = DatabaseHelper();
//      await db.deleteCard(id);
//    }
//    queryAllData();
//  }

  ///删除一条数据
  deleteSingle(String id) {
    GraceBean bean = GraceBean();
    bean.objectId = id;
    bean.delete().then((BmobHandled bmobHandled) {
      showToast('删除成功');
      queryAllData();
    }).catchError((e) {
      showToast('删除失败');
      queryAllData();
    });
  }

  @override
  void dispose() {
    _subject.close();
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