import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FlameSmallLogo extends PositionComponent {
  static const _ratio = 89 / 122;

  FlameSmallLogo({
    double width = 89,
    this.color = Colors.white,
    super.position,
    super.anchor = const Anchor(0.5, 0.6352),
  }) : super(
          size: Vector2(width, width / _ratio),
        );

  Color color;

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
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

    final combinedPath = Path();

    final whiteFlamePaint = Paint()..color = color;
    final flamePath1 = Path()
      ..moveTo(29.3218, 64.7105)
      ..cubicTo(54.3318, 39.4949, 31.7809, 0, 31.7809, 0)
      ..cubicTo(33.135, 0, 74.143, 27.5461, 63.4029, 80.0658)
      ..cubicTo(60.0673, 84.5254, 55.4407, 89.1527, 49.1412, 93.4614)
      ..cubicTo(42.5725, 88.2163, 36.3107, 81.4633, 32.3229, 73.1687)
      ..cubicTo(31.0414, 70.5033, 30.1078, 67.6227, 29.3218, 64.7105);
    combinedPath.addPath(flamePath1, Offset.zero);

    final flamePath2 = Path()
      ..moveTo(43.6838, 121.993)
      ..cubicTo(37.2923, 114.161, 34.3231, 101.945, 41.8063, 97.8282)
      ..cubicTo(85.1325, 73.9906, 68.083, 41.5671, 68.083, 41.5671)
      ..cubicTo(68.083, 41.5671, 94.4202, 75.4348, 76.449, 108.445)
      ..cubicTo(68.3595, 116.802, 57.0261, 122, 44.4882, 122)
      ..cubicTo(44.2195, 122, 43.9513, 121.998, 43.6838, 121.993);
    combinedPath.addPath(flamePath2, Offset.zero);

    final flamePath3 = Path()
      ..moveTo(15.4772, 111.228)
      ..cubicTo(8.86687, 102.573, 5.60549, 91.2266, 6.1775, 79.8307)
      ..cubicTo(7.69968, 49.501, 29.9664, 16.9702, 29.9664, 16.9702)
      ..cubicTo(29.9664, 16.9702, 21.6422, 50.7387, 32.4, 73.1148)
      ..cubicTo(42.9515, 95.0621, 68.98, 105.649, 76.3911, 108.504)
      ..cubicTo(68.3056, 116.826, 56.9964, 121.999, 44.4883, 121.999)
      ..cubicTo(33.4081, 121.999, 23.2686, 117.94, 15.4772, 111.228);
    combinedPath.addPath(flamePath3, Offset.zero);

    canvas.drawPath(combinedPath, whiteFlamePaint);
    canvas.restore();
  }
}
