import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> imageList = [
    'images/joker1.jpg',
    'images/joker2.jpg',
    'images/joker3.jpg',
    'images/joker4.jpg',
    'images/joker5.png'
  ];

  @override
  Widget build(BuildContext context) {
    int _current = 0;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CarouselSlider(
            items: <Widget>[],
            autoPlay: true,
          ),
        ],
      ),
    );
  }
}
