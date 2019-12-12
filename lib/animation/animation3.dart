import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';

class Animation3 extends StatefulWidget {
  @override
  _Animation3State createState() => _Animation3State();
}

class _Animation3State extends State<Animation3>
    with SingleTickerProviderStateMixin {
  Animation flipAnimation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);

    flipAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Interval(0.0, 0.5, curve: Curves.linear), parent: controller));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flip Animation"),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Center(
            child: InkWell(
              onTap: () {
                controller.repeat();
              },
              child: Container(
                height: 200.0,
                width: 200.0,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.007)
                    ..rotateY(2 * pi * flipAnimation.value),
                  alignment: Alignment.center,
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    color: Colors.green.withOpacity(0.2),
                    child: RotationTransition(
                      turns: flipAnimation,
                      child: Center(
                        child: Text(
                          "This Flips",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
