import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grace_day/bloc/BlocProvider.dart';
import 'package:grace_day/bloc/ThemeDataBLoC.dart';
import 'package:grace_day/page/SetGrace.dart';
import 'package:grace_day/widget/CustomDialog.dart';
import 'package:grace_day/widget/GraceCard.dart';
import 'package:grace_day/model/GraceDay.dart';
import 'package:grace_day/page/CreateGrace.dart';
import 'package:grace_day/bloc/GraceCardBLoC.dart';
import 'package:shared_preferences/shared_preferences.dart';

///首页展示
class GraceShow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GraceShowState();
  }
}

class _GraceShowState extends State<GraceShow> {

  var themeIndex = 0; //已选中的主题颜色

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return SetGrace(lastIndex: themeIndex);
        }
    );
  }

  Future checkTheme(ThemeDataBLoC themeBLoC) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String color = prefs.getString('ThemeColor');
    if(color != null) {
      themeIndex = int.parse(color);
      themeBLoC.changeTheme(themeIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeDataBLoC themeBLoC = BlocProvider.of(context);
    final GraceCardBLoC cardBLoC = BlocProvider.of(context);
    checkTheme(themeBLoC);

    cardBLoC.queryAllData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '时光Lite',
          textScaleFactor: 1.3,
          style: TextStyle(
            fontFamily: 'fz',
            fontSize: 18.0
          ),
        ),
        elevation: 0.5,
        centerTitle: true,
        actions: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () => {
                  _showDialog()
                },
                child: Text(
                  '个性换肤',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'fz'
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: WillPopScope(
        child: Container(
          child: StreamBuilder<List<GraceDay>>(
            stream: cardBLoC.stream,
            initialData: cardBLoC.value,
            builder: (BuildContext context, AsyncSnapshot<List<GraceDay>> snapshot) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //每行三列
                  childAspectRatio: 2/3, //显示区域宽高相等
                  crossAxisSpacing: 16.0,
//                mainAxisSpacing: 16.0
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: index % 2 == 0 ? EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0) : EdgeInsets.only(right: 16.0,top: 8.0, bottom: 8.0),
                    child: GraceCard(graceDay: snapshot.data[index]),
                  );
                }
              );
            }
          ),
        ),
        onWillPop: _showExitAppDialog
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateGrace())),
        child: Icon(Icons.add)
      )
    );
  }

  Future<bool> _showExitAppDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return CustomDialog(
          title: '退出提示',
          content: '确定退出应用吗？',
          outsideDismiss: false,
          confirmTextColor: Theme.of(context).primaryColor,
          confirmCallback: () async {
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
        );
      }
    );
    return Future.value(false);
  }

}