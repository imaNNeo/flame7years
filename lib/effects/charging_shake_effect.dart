import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';

class ChargingShakeEffect extends Effect {
  ChargingShakeEffect(
    super.controller, {
    required this.maxIntensity,
    required this.target,
    super.onComplete,
  }) : _originalPosition = target.position.clone();

  final double maxIntensity;
  final Vector2 _originalPosition;
  final Random random = Random();
  final PositionProvider target;

  @override
  void apply(double progress) {
    // Intensity increases over time
    final currentIntensity = maxIntensity * progress;

    // Generate random shake offsets
    final offsetX = (random.nextDouble() * 2 - 1) * currentIntensity;
    final offsetY = (random.nextDouble() * 2 - 1) * currentIntensity;

    // Apply the random shake effect to the position
    target.position.setFrom(_originalPosition + Vector2(offsetX, offsetY));
  }

  @override
  void onFinish() {
    // Reset to the original position after shaking is done
    target.position.setFrom(_originalPosition);
    super.onFinish();
  }
}

class ShakeAndReleaseEffect extends Component
    with ParentIsA<PositionComponent> {
  ShakeAndReleaseEffect({
    this.chargeDuration = 2.0,
    this.onReleased,
  });

  final double chargeDuration;
  final VoidCallback? onReleased;

  @override
  void onLoad() {
    super.onLoad();
    final maxShakeIntensity = chargeDuration * 2.5;
    add(SequenceEffect(
      [
        ChargingShakeEffect(
          EffectController(duration: chargeDuration),
          maxIntensity: maxShakeIntensity,
          target: parent,
        ),
        MoveEffect.by(
          Vector2(0, -15),
          EffectController(duration: 0.1, reverseDuration: 0.1),
          target: parent,
          onComplete: onReleased,
        ),
        MoveEffect.to(
          parent.position.clone(),
          EffectController(
            duration: 1.0, // Bounce back duration
            curve: Curves.elasticOut, // Simulate spring-like bounce back
          ),
          target: parent,
        ),
      ],
      onComplete: () => removeFromParent,
    ));
  }
}
