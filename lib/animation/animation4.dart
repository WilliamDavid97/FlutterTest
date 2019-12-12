import 'package:flutter/material.dart';

class Animation4 extends StatefulWidget {
  @override
  _Animation4State createState() => _Animation4State();
}

class _Animation4State extends State<Animation4> {
  bool opened = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Radial Menu"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: opened
                  ? MediaQuery.of(context).size.width / 2 - 40.0
                  : MediaQuery.of(context).size.width / 2 - 150.0,
              top: (MediaQuery.of(context).size.height / 2) - 30.0,
              child: _buildOption(
                  Icon(Icons.games, color: Colors.white), Colors.purple)),
          AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: opened
                  ? MediaQuery.of(context).size.width / 2 - 40.0
                  : (MediaQuery.of(context).size.width / 2) - 120.0,
              top: opened
                  ? (MediaQuery.of(context).size.height / 2) - 40.0
                  : (MediaQuery.of(context).size.height / 2) - 110.0,
              child: _buildOption(
                  Icon(Icons.gps_fixed, color: Colors.white), Colors.purple)),
          AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: opened
                  ? MediaQuery.of(context).size.width / 2 - 40.0
                  : (MediaQuery.of(context).size.width / 2) + 80.0,
              top: (MediaQuery.of(context).size.height / 2) - 30.0,
              child: _buildOption(
                  Icon(Icons.grade, color: Colors.white), Colors.green)),
          AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: opened
                  ? MediaQuery.of(context).size.width / 2 - 40.0
                  : (MediaQuery.of(context).size.width / 2) + 50.0,
              top: opened
                  ? (MediaQuery.of(context).size.height / 2) - 40.0
                  : (MediaQuery.of(context).size.height / 2) - 110.0,
              child: _buildOption(
                  Icon(Icons.group_work, color: Colors.white), Colors.green)),
          AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: MediaQuery.of(context).size.width / 2 - 35.0,
              top: opened
                  ? (MediaQuery.of(context).size.height / 2) - 40.0
                  : (MediaQuery.of(context).size.height / 2) - 150.0,
              child: _buildOption(
                  Icon(Icons.headset, color: Colors.white), Colors.brown)),
          AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: MediaQuery.of(context).size.width / 2 - 35.0,
              top: opened
                  ? (MediaQuery.of(context).size.height / 2) - 40.0
                  : (MediaQuery.of(context).size.height / 2) + 80.0,
              child: _buildOption(
                  Icon(Icons.highlight_off, color: Colors.white),
                  Colors.deepOrange)),
          AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: opened
                  ? MediaQuery.of(context).size.width / 2 - 40.0
                  : MediaQuery.of(context).size.width / 2 - 110.0,
              top: opened
                  ? (MediaQuery.of(context).size.height / 2) - 40.0
                  : (MediaQuery.of(context).size.height / 2) + 50.0,
              child: _buildOption(
                  Icon(Icons.history, color: Colors.white), Colors.deepOrange)),
          AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: opened
                  ? MediaQuery.of(context).size.width / 2 - 40.0
                  : MediaQuery.of(context).size.width / 2 + 50.0,
              top: opened
                  ? (MediaQuery.of(context).size.height / 2) - 40.0
                  : (MediaQuery.of(context).size.height / 2) + 50.0,
              child: _buildOption(
                  Icon(Icons.business_center, color: Colors.white),
                  Colors.deepOrange)),
          Align(
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(child: child, scale: animation);
              },
              child: opened
                  ? InkWell(
                      key: UniqueKey(),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: Colors.blue),
                          child: Center(
                            child: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          opened = false;
                        });
                      },
                    )
                  : InkWell(
                      key: UniqueKey(),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: Colors.red),
                          child: Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          opened = true;
                        });
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOption(Icon icon, Color iconColor) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation animation) {
        return RotationTransition(
          child: child,
          turns: animation,
        );
      },
      child: InkWell(
        key: UniqueKey(),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0), color: iconColor),
            child: Center(
              child: icon,
            ),
          ),
        ),
        onTap: () {
          setState(() {
            opened = false;
          });
        },
      ),
    );
  }
}
