import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_calculator/models/my_model.dart';

// ignore: must_be_immutable
class Button extends StatefulWidget {
  String text;
  Widget child;
  Color color = Colors.white;
  Button(this.text, {double fontSize = 20}) {
    child = Text('$text', style: TextStyle(fontSize: fontSize));
  }
  Button.sign(this.text, {double fontSize = 24}) {
    child = Text(
      '${text.replaceAll('*', '×').replaceAll('/', '÷')}',
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  Button.op(this.text) {
    if (text == 'x') {
      child = Icon(Icons.backspace, size: 21, color: Colors.redAccent);
    } else {
      child = Text(
        '$text',
        style: TextStyle(
          fontSize: text == '=' ? 28 : 22,
          color: Colors.redAccent,
          fontWeight: FontWeight.w800,
        ),
      );
    }
  }

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _sizeAnim;
  bool isComplete = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _sizeAnim = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 1, end: 0.56), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.56, end: 1), weight: 50),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      isComplete = status == AnimationStatus.completed ? true : false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    print('_controller.dispose()');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Expanded(
          child: Consumer<MyModel>(
            builder: (BuildContext context, value, Widget child) {
              return MaterialButton(
                onLongPress: () {
                  if (widget.text == 'C') {
                    value.clearHistory();
                  }
                },
                onPressed: () {
                  isComplete ? _controller.reverse() : _controller.forward();
                  if (widget.text == '=') {
                    value.flexes = [1, 2];
                    value.notify();
                    value.isAddtoHistory = true;
                  } else if (widget.text == 'C' && value.value == '0') {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 1),
                        content: Text(
                          'LongPress... to clear history.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    value.flexes = [3, 1];
                    value.onPress(widget.text);
                  }
                },
                height: _sizeAnim.value * size.height * 0.1,
                minWidth: _sizeAnim.value * size.width * 0.3,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 0.01),
                ),
                elevation: 0,
                color: Colors.white,
                // highlightElevation: 0,
                splashColor: Colors.white,
                child: widget.child,
              );
            },
          ),
        );
      },
    );
  }
}
