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
    Bmob.initMasterKey("47bda463417af84c9d3b9c2443e64d97",
        "330c88b87107dcc376d36c0e20abc1d3", "351853aee84a221a323d1ea22a55540d");
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
