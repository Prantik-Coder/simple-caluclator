import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'evalue.dart';

class MyModel extends ChangeNotifier {
  String value = '';
  String ans = '';
  List flexes = [3, 1];
  List<String> history = [''];
  List<String> last2his = ['', ''];
  bool isAddtoHistory = false;

  loadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getString('value') ?? '0';
    ans = pref.getString('ans') ?? '0';
    last2his = pref.getStringList('last2his') ?? ['', ''];
    history = pref.getStringList('history') ?? [''];
    print('loaded');
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }

  addToHistory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    history.addAll([value, ans, '']);
    last2his = [value, ans];
    pref.setStringList('last2his', last2his);
    pref.setStringList('history', history);
    print('addedtohistory');
    notifyListeners();
  }

  clearHistory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    history.clear();
    last2his.clear();
    pref.setStringList('last2his', ['', '']);
    pref.setStringList('history', ['']);
    notifyListeners();
  }

  onPress(String text) async {
    if (isAddtoHistory) {
      isAddtoHistory = false;
      await addToHistory();

      if (isSign(text)) {
        value = ans;
      } else {
        value = '0';
      }
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      value = onPressed(text, value);
      pref.setString('value', value);

      ans = evalue(value).toString();
      
      if (ans.substring(ans.length - 2, ans.length) == '.0')
        ans = ans.replaceAll('.0', '');

      pref.setString('ans', ans);
    } catch (e) {
      ans = 'Error';
      pref.setString('ans', ans);
      print(e);
    }

    notifyListeners();
  }
}

String onPressed(String command, String value) {
  format(String val) {
    String values = '';
    List<String> signwh = [];

    for (int i = 0; i < val.length; i++) {
      if (isSign(val[i])) {
        signwh.add(value[i]);
        val = val.replaceRange(i, i + 1, ',');
      }
    }

    List list = val.split(',');
    for (int i = 0; i < list.length; i++) {
      dynamic v;
      try {
        v = int.parse(list[i]);
      } catch (e) {
        v = list[i];
      }
      // print('values = $values v = $v');
      try {
        values += '$v' + signwh[i];
      } catch (e) {
        values += '$v';
      }
    }
    return values;
  }

  if (command == 'C') {
    value = '0';
  } else if (command == 'x') {
    value = value.length != 1 ? value.substring(0, value.length - 1) : '0';
  } else if (isSign(command)) {
    if (isSign(value[value.length - 1])) {
      value = value.substring(0, value.length - 1) + command;
    } else {
      value = value + command;
    }
  } else {
    value += command;
    value = format(value);
  }
  return value;
}
