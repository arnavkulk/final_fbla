import 'package:flutter/material.dart';

class StyleConstants {
  static MediaQueryData? _mediaQueryData = null;

  //for iPhone SE2 - 647.0 and 375.0
  static double height = 0;
  static double width = 0;
  static bool initialized = false;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    if (_mediaQueryData == null) return;
    height = _mediaQueryData!.size.height -
        (_mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom);
    width = _mediaQueryData!.size.width -
        (_mediaQueryData!.padding.left + _mediaQueryData!.padding.right);
    initialized = true;
    print('height: ' + height.toString() + ' width: ' + width.toString());
  }
}
