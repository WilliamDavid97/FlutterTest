import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Widget ImageSlide = Container(
      height: 200,
      width: 100,
      child: Carousel(
        boxFit: BoxFit.fill,
        images: [
          AssetImage('images/joker1.jpg'),
          AssetImage('images/joker2.jpg'),
          AssetImage('images/joker3.jpg'),
          AssetImage('images/joker4.jpg'),
          AssetImage('images/joker5.png'),
        ],
      ),
    );
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ImageSlide,
        ],
      ),
      // body: SafeArea(
      //   child: Container(
      //       color: Colors.blue[100],
      //       child: Column(
      //         children: <Widget>[
      //           ListView(
      //             children: <Widget>[
      //               image_slider,
      //             ],
      //           ),
      //           SizedBox(
      //             height: 10.0,
      //           ),
      //           Text(
      //             'Title',
      //             style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //               fontSize: 30.0,
      //             ),
      //           ),
      //           SizedBox(
      //             height: 10.0,
      //           ),
      //           Text(
      //             'Vote Average => 7.8',
      //             style: TextStyle(fontSize: 20.0),
      //           ),
      //           SizedBox(
      //             height: 10.0,
      //           ),
      //           Text(
      //             'Vote Count => 4000',
      //             style: TextStyle(fontSize: 15.0),
      //           ),
      //           SizedBox(
      //             height: 10.0,
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Text(
      //               'A kindhearted street urchin named Aladdin embarks on a magical adventure after finding a lamp that releases a wisecracking genie while a power-hungry Grand Vizier vies for the same lamp that has the power to make their deepest wishes come true.',
      //               style: TextStyle(color: Colors.grey[700]),
      //             ),
      //           ),
      //         ],
      //       )),
      // ),
    );
  }
}
