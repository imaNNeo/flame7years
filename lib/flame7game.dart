import 'package:flame/camera.dart';
import 'package:flame/game.dart';

import 'flame7world.dart';

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
