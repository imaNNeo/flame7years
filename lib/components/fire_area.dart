import 'package:flame/components.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';

class FireArea extends PositionComponent {
  FireArea({
    required Vector2 position,
    required double radius,
  }) : super(
          position: position,
          size: Vector2.all(radius * 2),
          anchor: Anchor.center,
        );

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(
      Offset(
        size.x / 2,
        size.y / 2,
      ),
      size.x / 2,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = RadialGradient(
          colors: [
            orangeColor2.withOpacity(0),
            orangeColor2.withOpacity(1.0),
          ],
          stops: const [
            0.4,
            0.7,
          ],
        ).createShader(
          Rect.fromCircle(
            center: Offset(size.x / 2, size.y / 2),
            radius: size.x,
          ),
        ),
    );
  }
}