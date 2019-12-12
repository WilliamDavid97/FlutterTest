import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimationTest extends StatefulWidget {
  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest>
    with SingleTickerProviderStateMixin {
  Animation animation,
      delayAnimation,
      muchDelayAnimation,
      childAnimation,
      transformAnimation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 7), vsync: this);
    animation = IntTween(begin: 0, end: 10)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    delayAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    childAnimation = Tween(begin: 10.0, end: 125.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    transformAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(125.0),
            end: BorderRadius.circular(0.0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Animation Test", style: TextStyle(fontSize: 20)),
              centerTitle: true,
            ),
            body: Center(
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: transformAnimation.value,
                        image: DecorationImage(
                            image: AssetImage('images/joker5.png')),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Text('Loading ......'),
                          Text(animation.value.toString(),
                              style: TextStyle(fontSize: 40.0))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )

            // Container(
            //   width: childAnimation.value * 2.0,
            //   height: childAnimation.value * 2.0,
            //   child: Column(
            //     children: <Widget>[
            //       Transform(
            //         transform: Matrix4.translationValues(
            //             animation.value * width, 0.0, 0.0),
            //         child: Center(
            //           child: Container(
            //             child: Text('Animation',
            //                 style: TextStyle(
            //                     fontSize: 20.0, fontWeight: FontWeight.bold)),
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Transform(
            //         transform: Matrix4.translationValues(
            //             delayAnimation.value * width, 0.0, 0.0),
            //         child: Center(
            //           child: Container(
            //             child: Text('Delay Animation',
            //                 style: TextStyle(
            //                     fontSize: 20.0, fontWeight: FontWeight.bold)),
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Transform(
            //         transform: Matrix4.translationValues(
            //             muchDelayAnimation.value * width, 0.0, 0.0),
            //         child: Center(
            //           child: Container(
            //             child: Text('Much Delay Animation',
            //                 style: TextStyle(
            //                     fontSize: 20.0, fontWeight: FontWeight.bold)),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            );
      },
    );
  }
}
