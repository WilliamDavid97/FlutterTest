import 'package:flutter/material.dart';
import 'package:radial_button/widget/circle_floating_button.dart';

class RadialTest extends StatefulWidget {
  @override
  _RadialTestState createState() => _RadialTestState();
}

class _RadialTestState extends State<RadialTest> {
  List<Widget> itemsActionBar;
  List<Widget> itemsToBody;

  @override
  void initState() {
    itemsActionBar = [
      FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        onPressed: () {},
        child: Icon(Icons.camera),
      ),
      FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {},
        child: Icon(Icons.card_giftcard),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Stack(
            children: <Widget>[],
          ),
        ),
      ),
      floatingActionButton: CircleFloatingButton.floatingActionButton(
        // key: key01,
        items: itemsActionBar,
        color: Colors.redAccent,
        icon: Icons.ac_unit,
        duration: Duration(milliseconds: 1000),
        curveAnim: Curves.ease,
      ),
    );
  }
}
