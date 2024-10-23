import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame7years/effects/charging_shake_effect.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';

import 'flame_small_logo.dart';

class FlameAuthor extends PositionComponent with TapCallbacks {
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
      FlameSmallLogo(
        color: authorColor,
        width: size.x,
        anchor: Anchor.topLeft,
      ),
      _leftEye = FlameAuthorEye(),
      _rightEye = FlameAuthorEye(),
    ]);
    nextBlinkIn = getNextBlinkIn();
  }

  @override
  void onTapDown(TapDownEvent event) {
    add(ShakeAndReleaseEffect(
      onReleased: () {
        print('Released!');
      },
      chargeDuration: 1.0,
    ));
    super.onTapDown(event);
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
