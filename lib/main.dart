import 'package:data_plugin/bmob/bmob.dart';
import 'package:flutter/material.dart';
import 'package:grace_day/bloc/BlocProvider.dart';
import 'package:grace_day/bloc/GraceCardBLoC.dart';
import 'package:grace_day/bloc/ThemeDataBLoC.dart';
import 'package:grace_day/page/Login.dart';

void main() => runApp(
  BlocProvider<ThemeDataBLoC>(
    bloC: ThemeDataBLoC(),
    child: BlocProvider<GraceCardBLoC>(
      bloC: GraceCardBLoC(),
      child: MyApp()
    ),
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Bmob SDK初始化，将appId,apiKey,masterKey替换自己的真实值。
    Bmob.initMasterKey('appId', 'apiKey', 'masterKey');
    final ThemeDataBLoC bloc = BlocProvider.of(context);
    return StreamBuilder<ThemeData>(
      stream: bloc.stream,
      initialData: bloc.value,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp(
          title: '时光Lite',
          theme: snapshot.data,
          home: Login(),
        );
      },
    );
  }


}
