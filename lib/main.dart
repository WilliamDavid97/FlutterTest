import 'package:flutter/material.dart';
import 'package:flutter_api_test/detail.dart';
import 'package:flutter_api_test/firstPage.dart';
import 'package:flutter_api_test/secondPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Movie API test",
    home: DetailPage(),
  ));
}
