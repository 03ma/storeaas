import 'package:flutter/cupertino.dart';

class MSize {
  var size;
  var context;

  MSize(context) {
    this.context = context;
    size = MediaQuery.of(context).size;
  }

  double getWidth() {
    return size.width;
  }

  double getHeight() {
    return size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }
}
