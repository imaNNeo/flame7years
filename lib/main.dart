import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'flame7game.dart';

const orangeColor = Color(0xFFFEBC1E);
const orangeColor2 = Color(0xFFFF8835);
const redColor = Color(0xFFEA192F);

void main() {
  runApp(
    GameWidget(
      game: Flame7Game(),
    ),
  );
}
