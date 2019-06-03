import 'package:flutter/material.dart';
import 'package:grace_day/bloc/BlocProvider.dart';
import 'package:grace_day/bloc/ThemeDataBLoC.dart';
import 'package:shared_preferences/shared_preferences.dart';

///换肤弹窗
class SetGrace extends StatefulWidget {
  final lastIndex;
  const SetGrace({Key key, this.lastIndex}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SetGraceState();
  }
}

class _SetGraceState extends State<SetGrace> {
  var selectIndex = 0;

  @override
  void initState() {
    super.initState();
    selectIndex = widget.lastIndex;
  }

  void selectCardColor(int index) {
    selectIndex = index;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeDataBLoC>(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;

    Column _container = Column(
      children: <Widget>[
        Container(
          height: 52.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(''),
                flex: 15,
              ),
              GestureDetector(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Offstage(
                      offstage: !(selectIndex == 0),
                      child: CircleAvatar(
                        backgroundColor: Colors.green[200],
                        radius: 26.0,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 23.0,
                    ),
                  ],
                ),
                onTap: () => {
                  selectCardColor(0)
                },
              ),
              Expanded(
                child: Text(''),
                flex: 10,
              ),
              GestureDetector(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Offstage(
                      offstage: !(selectIndex == 1),
                      child: CircleAvatar(
                        backgroundColor: Colors.red[200],
                        radius: 26.0,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 23.0,
                    ),
                  ],
                ),
                onTap: () => {
                  selectCardColor(1)
                },
              ),
              Expanded(
                child: Text(''),
                flex: 10,
              ),
              GestureDetector(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Offstage(
                      offstage: !(selectIndex == 2),
                      child: CircleAvatar(
                        backgroundColor: Colors.pink[200],
                        radius: 26.0,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.pink,
                      radius: 23.0,
                    ),
                  ],
                ),
                onTap: () => {
                  selectCardColor(2)
                },
              ),
              Expanded(
                child: Text(''),
                flex: 15,
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          height: 52.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(''),
                flex: 15,
              ),
              GestureDetector(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Offstage(
                      offstage: !(selectIndex == 3),
                      child: CircleAvatar(
                        backgroundColor: Colors.teal[200],
                        radius: 26.0,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 23.0,
                    ),
                  ],
                ),
                onTap: () => {
                  selectCardColor(3)
                },
              ),
              Expanded(
                child: Text(''),
                flex: 10,
              ),
              GestureDetector(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Offstage(
                      offstage: !(selectIndex == 4),
                      child: CircleAvatar(
                        backgroundColor: Colors.blue[200],
                        radius: 26.0,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 23.0,
                    ),
                  ],
                ),
                onTap: () => {
                  selectCardColor(4)
                },
              ),
              Expanded(
                child: Text(''),
                flex: 10,
              ),
              GestureDetector(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Offstage(
                      offstage: !(selectIndex == 5),
                      child: CircleAvatar(
                        backgroundColor: Colors.purple[200],
                        radius: 26.0,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.purple,
                      radius: 23.0,
                    ),
                  ],
                ),
                onTap: () => {
                  selectCardColor(5)
                },
              ),
              Expanded(
                child: Text(''),
                flex: 15,
              )
            ],
          ),
        )
      ],
    );

    Column _column = Column(
      children: <Widget>[
        SizedBox(
            height: 25.0,
        ),
        Expanded(
            child: Center(
              child: _container,
            ),
            flex: 1
        ),
        SizedBox(
            height: 1.0,
            child: Container(color: Color(0xDBDBDBDB))
        ),
        Container(
            height: 45,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.0))
                      ),
                      child: FlatButton(
                        child: Text(
                            '取消',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            )
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        splashColor:  Color(0xFFFFFFFF),
                        highlightColor: Color(0xFFFFFFFF),
                      ),
                    ),
                    flex: 1
                ),
                SizedBox(width: 1.0, child: Container(color: Color(0xDBDBDBDB))),
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.0))
                      ),
                      child: FlatButton(
                        onPressed: () =>{confirmTheme(themeBloc)},
                        child: Text(
                            '确定',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).primaryColor,
                            )
                        ),
                        splashColor: Color(0xFFFFFFFF),
                        highlightColor:Color(0xFFFFFFFF),
                      ),
                    ),
                    flex: 1
                ),
              ],
            )
        )
      ],
    );

    return WillPopScope(
        child: GestureDetector(
          onTap: () => {
            Navigator.of(context).pop()
          },
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                width: width - 80.0,
                height: 220.0,
                alignment: Alignment.center,
                child: _column,
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(12.0)
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return true;
        }
    );

  }

  void confirmTheme(ThemeDataBLoC themeBloc) async {
    themeBloc.changeTheme(selectIndex);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ThemeColor', selectIndex.toString());
    Navigator.pop(context);
  }

}