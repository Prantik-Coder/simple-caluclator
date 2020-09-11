import 'package:flutter/material.dart';
import 'buttons_area.dart';
import 'text_area.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(color: Colors.black, thickness: 0.16, height: 1),
          Expanded(
            flex: 2,
            child: TextArea(),
          ),
          Expanded(
            flex: 3,
            child: ButtonsArea(),
          )
        ],
      ),
    );
  }
}

