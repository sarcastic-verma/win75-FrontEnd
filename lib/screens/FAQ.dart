import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  static const id = '/FAQ';
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FAQ's and Support"),
        ),
        body: SingleChildScrollView());
  }
}
