import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test/upload_test/upload_test.dart';

import 'animation/animation1.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  CarouselSlider carouselSlider;
  int _current = 0;
  List<String> imageList = [
    'images/joker1.jpg',
    'images/joker2.jpg',
    'images/joker3.jpg',
    'images/joker4.jpg',
    'images/joker5.png'
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      padding: EdgeInsets.only(top: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          carouselSlider = CarouselSlider(
            height: 200.0,
            initialPage: 0,
            enlargeCenterPage: true,
            autoPlayInterval: Duration(seconds: 2),
            autoPlay: true,
            reverse: false,
            autoPlayAnimationDuration: Duration(milliseconds: 2000),
            pauseAutoPlayOnTouch: Duration(seconds: 5),
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
            items: imageList.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Image.asset(
                      imgUrl,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(imageList, (index, url) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.redAccent : Colors.green,
                ),
              );
            }),
          ),
          SizedBox(
            height: 2.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: goToPrevious,
                child: Text('<'),
              ),
              OutlineButton(
                onPressed: goToNext,
                child: Text('>'),
              ),
            ],
          ),
          FlatButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AnimationTest()));
            },
            icon: Icon(Icons.file_upload),
            label: Text("Animation"),
          )
        ],
      ),
    );
  }

  goToPrevious() {
    carouselSlider.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  goToNext() {
    carouselSlider.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
  }
}
