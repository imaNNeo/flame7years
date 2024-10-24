import 'package:flame/components.dart';
import 'package:flame7years/components/big_flame_points.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';

class FireArea extends PositionComponent {
  FireArea({
    required this.id,
    required Vector2 position,
    required double radius,
    required double initialIntensity,
    required this.containingPoints,
    this.onIntensityChanged,
  })  : _currentIntensity = initialIntensity,
        super(
          position: position,
          size: Vector2.all(radius * 2),
          anchor: Anchor.center,
        );

  final int id;
  double _currentIntensity = 0.0;
  double get intensity => _currentIntensity;
  void Function(FireArea value, double diff)? onIntensityChanged;
  List<BigFlamePoint> containingPoints;

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
            orangeColor2.withOpacity(_currentIntensity.clamp(0, 1)),
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

  @override
  void update(double dt) {
    super.update(dt);
    final previousIntensity = _currentIntensity;
    _currentIntensity -= dt * 0.05;
    if (_currentIntensity <= 0) {
      _currentIntensity = 0;
    }
    final diff = _currentIntensity - previousIntensity;
    onIntensityChanged?.call(this, diff);
  }
}
