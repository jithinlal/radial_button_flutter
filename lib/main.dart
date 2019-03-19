import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radio_button/second_route.dart';
import 'package:vector_math/vector_math.dart' show radians;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SizedBox.expand(
          child: RadialMenu(),
        ),
      ),
    );
  }
}

class RadialMenu extends StatefulWidget {
  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 900),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key key, this.controller})
      : scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        translation = Tween<double>(begin: 0.0, end: 100.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeInOut,
          ),
        ),
        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.5,
              curve: Curves.decelerate,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;
  final Animation<double> rotation;

  build(context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (currentContext, builder) {
        return Transform.rotate(
          angle: radians(rotation.value),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildButton(currentContext, 0, 'Train Fare Enquiry',
                  color: Colors.green, icon: FontAwesomeIcons.moneyBillWave),
              _buildButton(currentContext, 90, 'Live Train Status',
                  color: Colors.red, icon: FontAwesomeIcons.hourglass),
              _buildButton(currentContext, 180, 'PNR Status',
                  color: Colors.blue, icon: FontAwesomeIcons.infoCircle),
              _buildButton(currentContext, 270, 'Seat Availability',
                  color: Colors.pinkAccent, icon: FontAwesomeIcons.chair),
              Transform.scale(
                scale: scale.value - 1.5,
                child: FloatingActionButton(
                  child: Icon(FontAwesomeIcons.timesCircle),
                  heroTag: "close",
                  onPressed: _close,
                  backgroundColor: Colors.red,
                ),
              ),
              Transform.scale(
                scale: scale.value,
                child: FloatingActionButton(
                  child: Icon(FontAwesomeIcons.train),
                  heroTag: "open",
                  onPressed: _open,
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }

  _buildButton(
    final BuildContext context,
    double angle,
    String text, {
    Color color,
    IconData icon,
  }) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (translation.value) * cos(rad),
          (translation.value) * sin(rad),
        ),
      child: FloatingActionButton(
        child: Icon(icon),
        backgroundColor: color,
        heroTag: text,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (anotherContext) {
              return SecondRoute(
                text: text,
                color: color,
                icon: icon,
              );
            }),
          );
        },
        tooltip: text,
      ),
    );
  }
}
