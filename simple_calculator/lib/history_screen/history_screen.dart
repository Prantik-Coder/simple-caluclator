import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List history;
  final List valueAndAns;

  const HistoryScreen({
    Key key,
    this.history,
    this.valueAndAns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(history);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'longpress c button to clear history...',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: history.map((his) {
                  if (his == '') return SizedBox(height: 5);
                  return Text(his);
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Divider(color: Colors.black)),
                  Text(
                    '  current  ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  Expanded(flex: 5, child: Divider(color: Colors.black)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: valueAndAns
                  .map(
                    (his) => Text(
                      his,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
