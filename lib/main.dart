import 'package:flutter/material.dart';
import 'widgets/home_page/HomePage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Finder',
      home: HomePage(),
    );
  }
}
