import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';

class FlameAuthor extends PositionComponent {
  static const _ratio = 89 / 122;

  FlameAuthor({
    double width = 89,
    required Vector2 position,
    this.authorColor = Colors.white,
  }) : super(
          size: Vector2(width, width / _ratio),
          position: position,
          anchor: const Anchor(0.5, 0.6352),
        );

  late FlameAuthorEye _leftEye, _rightEye;
  final ui.Color authorColor;
  late double nextBlinkIn;

  double getNextBlinkIn() => 4 + 4 * Random().nextDouble();

  @override
  void onLoad() {
    super.onLoad();
    addAll([
      _leftEye = FlameAuthorEye(),
      _rightEye = FlameAuthorEye(),
    ]);
    nextBlinkIn = getNextBlinkIn();
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.scale(size.x / 89, size.y / 122);
    final gradientPaint = Paint()
      ..shader = ui.Gradient.radial(
        const Offset(50.8726, 83.9879),
        52.7141, // Radius
        [Colors.white.withOpacity(0), Colors.white.withOpacity(0.29)],
      );
    final circlePath = Path()
      ..addOval(
        Rect.fromCircle(
          center: const Offset(44.4858, 77.5139),
          radius: 44.4858,
        ),
      );
    canvas.drawPath(circlePath, gradientPaint);

    final whiteFlamePaint = Paint()..color = authorColor;
    final flamePath1 = Path()
      ..moveTo(29.3218, 64.7105)
      ..cubicTo(54.3318, 39.4949, 31.7809, 0, 31.7809, 0)
      ..cubicTo(33.135, 0, 74.143, 27.5461, 63.4029, 80.0658)
      ..cubicTo(60.0673, 84.5254, 55.4407, 89.1527, 49.1412, 93.4614)
      ..cubicTo(42.5725, 88.2163, 36.3107, 81.4633, 32.3229, 73.1687)
      ..cubicTo(31.0414, 70.5033, 30.1078, 67.6227, 29.3218, 64.7105);
    canvas.drawPath(flamePath1, whiteFlamePaint);

    final flamePath2 = Path()
      ..moveTo(43.6838, 121.993)
      ..cubicTo(37.2923, 114.161, 34.3231, 101.945, 41.8063, 97.8282)
      ..cubicTo(85.1325, 73.9906, 68.083, 41.5671, 68.083, 41.5671)
      ..cubicTo(68.083, 41.5671, 94.4202, 75.4348, 76.449, 108.445)
      ..cubicTo(68.3595, 116.802, 57.0261, 122, 44.4882, 122)
      ..cubicTo(44.2195, 122, 43.9513, 121.998, 43.6838, 121.993);
    canvas.drawPath(flamePath2, whiteFlamePaint);

    final flamePath3 = Path()
      ..moveTo(15.4772, 111.228)
      ..cubicTo(8.86687, 102.573, 5.60549, 91.2266, 6.1775, 79.8307)
      ..cubicTo(7.69968, 49.501, 29.9664, 16.9702, 29.9664, 16.9702)
      ..cubicTo(29.9664, 16.9702, 21.6422, 50.7387, 32.4, 73.1148)
      ..cubicTo(42.9515, 95.0621, 68.98, 105.649, 76.3911, 108.504)
      ..cubicTo(68.3056, 116.826, 56.9964, 121.999, 44.4883, 121.999)
      ..cubicTo(33.4081, 121.999, 23.2686, 117.94, 15.4772, 111.228);
    canvas.drawPath(flamePath3, whiteFlamePaint);
    canvas.restore();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _leftEye.position = Vector2(size.x * 0.22, size.y * 0.685);
    _rightEye.position = Vector2(size.x * 0.44, size.y * 0.685);
    nextBlinkIn -= dt;
    if (nextBlinkIn <= 0) {
      _leftEye.blink();
      _rightEye.blink();
      nextBlinkIn = getNextBlinkIn();
    }
  }
}

class FlameAuthorEye extends PositionComponent with ParentIsA<FlameAuthor> {
  FlameAuthorEye()
      : super(
          anchor: Anchor.center,
        );

  @override
  void update(double dt) {
    super.update(dt);
    size = Vector2(parent.size.x * 0.1, parent.size.y * 0.16);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.x / 2, size.y / 2),
        width: size.x,
        height: size.y,
      ),
      Paint()..color = redColor,
    );
  }

  void blink() {
    add(
      ScaleEffect.to(
        Vector2(1, 0),
        EffectController(
          duration: 0.1,
          repeatCount: 1,
          onMax: () => add(
            ScaleEffect.to(
              Vector2(1, 1),
              EffectController(
                duration: 0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
