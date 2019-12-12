import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class TestingAnimate extends StatefulWidget {
  @override
  _TestingAnimateState createState() => _TestingAnimateState();
}

class _TestingAnimateState extends State<TestingAnimate>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animateController;

  @override
  void initState() {
    super.initState();
    animateController =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
    animation = Tween(begin: 0.0, end: -0.15).animate(
        CurvedAnimation(parent: animateController, curve: Curves.ease));
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: animateController,
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
                      padding: EdgeInsets.all(10.0),
                      width: 350,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {},
                            child: Text("Buy"),
                            elevation: 7.0,
                            color: Colors.blue,
                            textColor: Colors.white,
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Text("Detail"),
                            elevation: 7.0,
                            color: Colors.blue,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: 350,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: AssetImage('images/joker3.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        transform: Matrix4.translationValues(
                            0.0, animation.value * width, 0.0),
                      ),
                      onTap: () {
                        animateController.forward();
                      },
                      onDoubleTap: () {
                        animateController.reverse();
                      },
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
