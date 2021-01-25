import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void errorMsg(context, text) {
  Toast.show(text, context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.red);
}
