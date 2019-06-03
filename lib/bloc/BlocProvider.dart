import 'package:flutter/material.dart';
import 'package:grace_day/bloc/BLoCBase.dart';

class BlocProvider<T extends BLoCBase> extends StatefulWidget {

  final T bloC;
  final Widget child;

  BlocProvider({Key key, @required this.bloC, @required this.child}) : super(key: key);

  @override
  _BlocProviderState<T> createState() {
    return _BlocProviderState<T>();
  }

  static T of<T extends BLoCBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloC;
  }

  static Type _typeOf<T>() => T;

}

class _BlocProviderState<T> extends State<BlocProvider<BLoCBase>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    super.dispose();
  }

}