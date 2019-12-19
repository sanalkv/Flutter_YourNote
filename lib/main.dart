import 'package:flutter/material.dart';
import './home.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.orange,
          accentColor: Colors.orangeAccent,
          fontFamily: 'Times New Roman'),
      title: "my app",
      home: Flare(),
      debugShowCheckedModeBanner: false,
    );
  }
}
