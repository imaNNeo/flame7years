import 'package:flame/components.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Background extends PositionComponent with HasGameRef {
  final double interval;

  Background({
    this.interval = 40,
  });

  @override
  void onLoad() {
    super.onLoad();
    size = gameRef.size;
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = orangeColor.withOpacity(0.3)
      ..strokeWidth = 1;
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      Paint()..color = redColor.withOpacity(0.2),
    );
    for (var i = 1; i < size.x / interval; i++) {
      canvas.drawLine(
        Offset(i * interval, 0),
        Offset(i * interval, size.y),
        paint,
      );
    }
    for (var i = 1; i < size.y / interval; i++) {
      canvas.drawLine(
        Offset(0, i * interval),
        Offset(size.x, i * interval),
        paint,
      );
    }
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      Paint()
        ..shader = ui.Gradient.radial(
          Offset(size.x / 2, size.y / 2),
          size.x / 2,
          [Colors.black12, Colors.black],
        ),
    );
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 1,
      Paint()
        ..color = Colors.black
        ..strokeWidth = size.x
        ..style = PaintingStyle.stroke,
    );
  }
}
