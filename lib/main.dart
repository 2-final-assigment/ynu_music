import 'package:flutter/material.dart';
import './home.dart';
import 'package:provider/provider.dart';
import 'store/common.dart';

void main() {
  // ignore: non_constant_identifier_names
  final Model = new CommonModel();
  runApp(Provider<Set<String>>.value(
    value: null,
    child: ChangeNotifierProvider.value(
      value: Model,
      child: new MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Music',
      home: Home(),
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}
