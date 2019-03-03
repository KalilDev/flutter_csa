import 'package:flutter/material.dart';
import 'webpage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Colégio Santo Antonio",
      home: new WebPage(),
    );
  }
}