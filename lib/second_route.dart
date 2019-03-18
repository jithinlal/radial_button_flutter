import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  SecondRoute(
      {Key key, @required this.text, @required this.color, @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.color,
        title: Text(this.text),
      ),
      body: Center(
        child: Icon(this.icon),
      ),
    );
  }
}
