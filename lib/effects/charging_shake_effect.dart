import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/particles.dart';
import 'package:flame7years/components/flame_author.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';
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
  final FlameAuthor target;

  @override
  void apply(double progress) {
    // Intensity increases over time
    final currentIntensity = maxIntensity * progress;

    // Generate random shake offsets
    final offsetX = (random.nextDouble() * 2 - 1) * currentIntensity;
    final offsetY = (random.nextDouble() * 2 - 1) * currentIntensity;

    // Apply the random shake effect to the position
    target.position.setFrom(_originalPosition + Vector2(offsetX, offsetY));
    target.overlayColor = Color.lerp(
      orangeColor.withOpacity(0.0),
      redColor.withOpacity(0.7),
      progress,
    )!;
  }

  @override
  void onFinish() {
    // Reset to the original position after shaking is done
    target.position.setFrom(_originalPosition);
    target.overlayColor = redColor.withOpacity(0.0);

    final particlePositionXRange = target.size.x;
    const startColor = redColor;
    const endColor = orangeColor;
    target.game.world.add(ParticleSystemComponent(
      priority: target.priority + 1,
      position: target.absolutePosition,
      particle: Particle.generate(
        count: 10,
        lifespan: 0.6,
        generator: (i) => AcceleratedParticle(
          position: Vector2(
            (Random().nextDouble() * particlePositionXRange) -
                (particlePositionXRange / 2),
            -target.size.y * 0.3,
          ),
          speed: Vector2(
            0,
            -(Random().nextDouble() * 160 + 40),
          ),
          child: ComputedParticle(renderer: (canvas, particle) {
            final size = lerpDouble(6.0, 0.0, particle.progress)!;
            canvas.drawOval(
              Rect.fromCenter(
                center: Offset.zero,
                width: size,
                height: size * 2,
              ),
              Paint()
                ..color = Color.lerp(
                  startColor,
                  endColor,
                  particle.progress,
                )!,
            );
          }),
        ),
      ),
    ));
    super.onFinish();
  }
}

class ShakeAndReleaseEffect extends Component with ParentIsA<FlameAuthor> {
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
          onComplete: onReleased,
        ),
        MoveEffect.by(
          Vector2(0, -15),
          EffectController(duration: 0.1, reverseDuration: 0.1),
          target: parent,
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
