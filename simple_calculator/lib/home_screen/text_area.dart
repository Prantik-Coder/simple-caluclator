import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_calculator/history_screen/history_screen.dart';
import 'package:simple_calculator/models/my_model.dart';

class TextArea extends StatelessWidget {
  const TextArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyModel>(
      builder: (BuildContext context, value, Widget child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryScreen(
                          valueAndAns: [value.value, value.ans],
                          history: value.history,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 18),
                    alignment: Alignment.centerRight,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: value.last2his.map((his) {
                        return Text(
                          his,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          flex: value.flexes[0],
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8),
                            alignment: Alignment.bottomRight,
                            child: AutoSizeText(
                              '${value.value.replaceAll('*', '×').replaceAll('/', '÷')}',
                              style: TextStyle(fontSize: 56),
                              maxFontSize: 80,
                              minFontSize: 20,
                              textAlign: TextAlign.end,
                            ),
                          )),
                      Expanded(
                        flex: value.flexes[1],
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(bottom: 2, top: 3, left: 8),
                          child: AutoSizeText(
                            '=${value.ans.replaceAll('*', '×').replaceAll('/', '÷')}',
                            style: TextStyle(
                              fontSize: 60,
                              color: Colors.grey[700],
                            ),
                            minFontSize: 8,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
