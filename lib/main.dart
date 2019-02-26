import 'package:flutter/material.dart';
import 'webpage.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Calculator App",
      theme: ThemeData.dark(),
      home: new WebPage(),
    );
  }
}