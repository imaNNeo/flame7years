import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame7years/components/fire_area.dart';
import 'package:flutter/material.dart';

import 'components/background.dart';
import 'components/flame_author.dart';
import 'components/flame_large_logo.dart';

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

class Flame7Game extends FlameGame<Flame7World> {
  Flame7Game()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 800,
            height: 800,
          ),
          world: Flame7World(),
        );
}

class Flame7World extends World with HasGameRef<Flame7Game> {
  final List<FireArea> _fireAreas = [];

  @override
  void onLoad() {
    super.onLoad();
    add(Background());
    add(FlameAuthor(
      width: 60,
      position: Vector2(160, -300),
    ));
    add(FlameLargeLogo(width: 500));
  }

  void addFireArea(Vector2 position, double radius) {
    final fireArea = FireArea(
      position: position,
      radius: radius,
    );
    add(fireArea);
    _fireAreas.add(fireArea);
  }
}
