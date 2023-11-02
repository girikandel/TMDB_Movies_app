import 'package:flutter/material.dart';
import 'package:movieapp/utils/extensions.dart';

EdgeInsets bodyOnlyPadding(BuildContext context) {
  return EdgeInsets.only(
      left: 0.030.w(context), right: 0.030.w(context), top: 0.020.h(context));
}

EdgeInsets verticalPadding(BuildContext context) {
  return EdgeInsets.symmetric(vertical: 0.020.h(context));
}

EdgeInsets horizontalPadding(BuildContext context) {
  return EdgeInsets.symmetric(horizontal: 0.015.h(context));
}
