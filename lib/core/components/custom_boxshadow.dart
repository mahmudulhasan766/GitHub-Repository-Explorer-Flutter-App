import 'package:flutter/material.dart';

BoxShadow customBoxShadow({
  Color color = const Color(0xFF000000),
  Offset offset = Offset.zero,
  double blurRadius = 0.0,
  double spreadRadius = 0.0,
}) {
  return BoxShadow(
    color: color,
    offset: offset,
    blurRadius: blurRadius,
    spreadRadius: spreadRadius,
  );
}
