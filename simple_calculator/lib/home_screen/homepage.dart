import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_calculator/home_screen/body.dart';
import 'package:simple_calculator/models/my_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MyModel>(context, listen: false).loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
