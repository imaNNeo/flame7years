import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class AuthorMovingAnimationEffect extends MoveByEffect {
  AuthorMovingAnimationEffect({
    double offset = 10,
  }) : super(
          Vector2(0, offset),
          EffectController(
            duration: 0.5,
            infinite: true,
            alternate: true,
          ),
        );
}
