import 'package:flutter/material.dart';
import 'button.dart';

class ButtonsArea extends StatelessWidget {
  const ButtonsArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[100],
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(2, -3),
              blurRadius: 8,
              spreadRadius: 1,
              color: Colors.grey[200]
            )
          ]),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Button.sign('*'),
                Button('7'),
                Button('4'),
                Button('1'),
                Button(''),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Button.sign('/'),
                Button('8'),
                Button('5'),
                Button('2'),
                Button('0'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Button.sign('+'),
                Button('9'),
                Button('6'),
                Button('3'),
                Button('.', fontSize: 32),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Button.sign('-', fontSize: 30),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Button.op('C'),
                      Button.op('x'),
                      Button.op('='),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
