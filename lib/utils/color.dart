import 'package:flutter/material.dart';
import 'dart:math';

final List<Color> colors = [
  Colors.amber,
  Colors.blue,
  Colors.cyan,
  Colors.green,
  Colors.indigo,
  Colors.lime,
  Colors.orange,
  Colors.purple,
  Colors.red,
  Colors.teal,
  Colors.yellow,
];
Random rnd = new Random();

Color getRandomColor() {
  return colors[rnd.nextInt(colors.length)];
}
