const List allSigns = ['+', '-', '*', '/'];

bool isSign(String text, {List signs: allSigns}) {
  for (String sing in signs) {
    if (text == sing) return true;
  }
  return false;
}

double evalue(String value) {
  print('start... $value');
  //
  doFormat() {
    if (value[0] == '+' || value[0] == '-') {
      value = '0' + value;
    } else if (isSign(value[0])) {
      value = value.substring(1, value.length);
    }
    if (isSign(value[value.length - 1])) {
      value = value.substring(0, value.length - 1);
    }
  }

  doFormat();
  print('first format... $value');

  Type stringToList(String value, {List signs: allSigns}) {
    List<String> signWh = [];
    for (int i = 0; i < value.length; i++) {
      if (isSign(value[i], signs: signs)) {
        signWh.add(value[i]);
        value = value.replaceRange(i, i + 1, ',');
      }
    }
    return Type(value.split(','), signWh);
  }

  double doProcess(Type type) {
    List val = type.value;
    List signs = type.signs;
    double toDouble(String val) {
      return double.parse(val);
    }

    double value = toDouble(val[0]);
    if (val.length > 1) {
      for (int i = 0; i < signs.length; i++) {
        if (signs[i] == '+') {
          value += toDouble(val[i + 1]);
        } else if (signs[i] == '-') {
          value -= toDouble(val[i + 1]);
        } else if (signs[i] == '*') {
          value *= toDouble(val[i + 1]);
        } else if (signs[i] == '/') {
          value /= toDouble(val[i + 1]);
        }
      }
    }
    return value;
  }

  List<dynamic> list = stringToList(value, signs: ['+', '-']).value;
  List<dynamic> signs = stringToList(value, signs: ['+', '-']).signs;

  print('second format... $list ${stringToList(value).signs}');

  for (int i = 0; i < list.length; i++) {
    list[i] = doProcess(stringToList(list[i])).toString();
  }
  print('last format.... $list');

  double ans = doProcess(Type(list, signs));
  print('Answer = $ans');

  return ans;
}

class Type {
  List value;
  List signs;
  Type(this.value, this.signs);
}
