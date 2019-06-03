import 'package:grace_day/bloc/BLoCBase.dart';
import 'package:grace_day/db/DatabaseHelper.dart';
import 'package:grace_day/model/GraceDay.dart';
import 'package:rxdart/rxdart.dart';

class GraceCardBLoC extends BLoCBase {

  List<GraceDay> _list = [];

  var _subject = BehaviorSubject<List<GraceDay>>();

  Stream<List<GraceDay>> get stream => _subject.stream;
  List<GraceDay> get value => _list;

  queryAllData() async {
    var db = DatabaseHelper();
    List<GraceDay> ls = await db.getAllCards();
    if (ls != null) {
      _list = ls;
    }
    _subject.sink.add(_list);
  }

  saveCardDB(GraceDay todo) async {
    var db = DatabaseHelper();
    await db.saveCard(todo);
    queryAllData();
  }

  void updateCardDB(GraceDay todo) async {
    var db = DatabaseHelper();
    await db.updateCard(todo);
    queryAllData();
  }

  void deleteCardDB(GraceDay todo) async {
    if (todo != null) {
      var id = todo.id;
      var db = DatabaseHelper();
      await db.deleteCard(id);
    }
    queryAllData();
  }

  @override
  void dispose() {
    _subject.close();
  }

}