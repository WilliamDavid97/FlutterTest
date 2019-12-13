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
        heroTag: '1',
        backgroundColor: Colors.greenAccent,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      FloatingActionButton(
        heroTag: '2',
        backgroundColor: Colors.indigoAccent,
        onPressed: () {},
        child: Icon(Icons.camera),
      ),
      FloatingActionButton(
        heroTag: '3',
        backgroundColor: Colors.orangeAccent,
        onPressed: () {},
        child: Icon(Icons.card_giftcard),
      ),
    ];
    super.initState();
  }

  bool toggleValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample"),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          height: 40.0,
          width: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: toggleValue
                ? Colors.greenAccent[100]
                : Colors.redAccent[100].withOpacity(0.5),
          ),
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeIn,
                top: 3.0,
                left: toggleValue ? 60.0 : 0.0,
                right: toggleValue ? 0.0 : 60.0,
                child: InkWell(
                  onTap: toggleButtons,
                  child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 1000),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          child: child,
                          scale: animation,
                        );
                      },
                      child: toggleValue
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 35.0,
                              key: UniqueKey(),
                            )
                          : Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                              size: 35.0,
                              key: UniqueKey(),
                            )),
                ),
              )
            ],
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

  toggleButtons() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}
