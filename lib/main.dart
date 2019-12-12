import 'package:flutter/material.dart';
import 'package:flutter_api_test/detail.dart';
import 'package:flutter_api_test/firstPage.dart';
import 'package:flutter_api_test/image_slider.dart';
import 'package:flutter_api_test/pokemon/mainPokemon.dart';

import 'animation/animation1.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Movie API test",
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text("Tab Bar Testing"),
        centerTitle: true,
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.movie),
            ),
            Tab(
              icon: Icon(Icons.broken_image),
            ),
            Tab(
              icon: Icon(Icons.import_export),
            ),
            Tab(
              icon: Icon(Icons.slideshow),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          ImageSlider(),
          MainPokemon(),
          FirstPage(),
          DetailPage(),
        ],
      ),
    );
  }
}
