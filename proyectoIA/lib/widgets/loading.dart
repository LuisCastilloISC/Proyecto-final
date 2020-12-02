import 'package:flutter/material.dart';
import 'dart:math';
import '../helpers/colors.dart' as fcolor;

class Loading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Loading();
  }
}

class _Loading extends State<Loading> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;
  final double initialradius = 30.0;
  double radius = 0.0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation_rotation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation_radius_in = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));
    animation_radius_out = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));
    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = animation_radius_in.value * initialradius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          radius = animation_radius_out.value * initialradius;
        }
      });
    });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 52,
      height: 52,
      child: Stack(
        children: <Widget>[
          Dot(
            radius: 15.0,
            color: fcolor.green,
          ),
          RotationTransition(
            turns: animation_rotation,
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(radius * cos(pi / 4), radius * sin(pi / 4)),
                  child: Dot(
                    radius: 5.0,
                    color: fcolor.green,
                  ),
                ),
                Transform.translate(
                    offset: Offset(
                        radius * cos(2 * pi / 4), radius * sin(2 * pi / 4)),
                    child: Dot(
                      radius: 5.0,
                      color: fcolor.green,
                    )),
                Transform.translate(
                    offset: Offset(
                        radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
                    child: Dot(
                      radius: 5.0,
                      color: fcolor.green,
                    )),
                Transform.translate(
                    offset: Offset(
                        radius * cos(4 * pi / 4), radius * sin(4 * pi / 4)),
                    child: Dot(
                      radius: 5.0,
                      color: fcolor.green,
                    )),
                Transform.translate(
                    offset: Offset(
                        radius * cos(5 * pi / 4), radius * sin(5 * pi / 4)),
                    child: Dot(
                      radius: 5.0,
                      color: fcolor.green,
                    )),
                Transform.translate(
                    offset: Offset(
                        radius * cos(6 * pi / 4), radius * sin(6 * pi / 4)),
                    child: Dot(
                      radius: 5.0,
                      color: fcolor.green,
                    )),
                Transform.translate(
                    offset: Offset(
                        radius * cos(7 * pi / 4), radius * sin(7 * pi / 4)),
                    child: Dot(
                      radius: 5.0,
                      color: fcolor.green,
                    )),
                Transform.translate(
                    offset: Offset(
                        radius * cos(8 * pi / 4), radius * sin(8 * pi / 4)),
                    child: Dot(
                      radius: 5.0,
                      color: fcolor.green,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  final IconData icon;
  Dot({this.radius, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: this.radius,
        backgroundColor: this.color,
        //child: Icon(icon),
      ),
    );
  }
}
