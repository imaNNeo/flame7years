import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/particles.dart';
import 'package:flame7years/flame7world.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';

class FlameFireball extends PositionComponent with ParentIsA<Flame7World> {
  FlameFireball({
    required super.position,
    required super.size,
    required this.speed,
    required this.target,
    this.onReachedTarget,
    super.anchor = Anchor.center,
    super.priority,
  });

  final double speed;
  final Vector2 target;
  final VoidCallback? onReachedTarget;

  double addParticleEvery = 0.04;
  double lastParticle = 0.0;

  final orangePaint = Paint()..color = orangeColor;

  final redPaint = Paint()..color = redColor;

  @override
  void onLoad() {
    super.onLoad();
    add(
      MoveToEffect(
        target,
        EffectController(
          duration: (position.distanceTo(target) / speed),
          onMax: () {
            onReachedTarget?.call();
            removeFromParent();
            final initialIntensity = max(size.x * 0.02, 0.1);
            parent.addFireArea(
              position,
              size.x * 2,
              initialIntensity,
            );
          },
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    lastParticle += dt;
    if (lastParticle >= addParticleEvery) {
      lastParticle = 0.0;
      parent.add(
        ParticleSystemComponent(
          position: absolutePosition,
          particle: Particle.generate(
            count: 3,
            lifespan: 0.4,
            generator: (i) {
              const startColor = redColor;
              const endColor = Colors.orange;
              final startSize = size.x / 4;
              return ComputedParticle(renderer: (canvas, particle) {
                final color = Color.lerp(
                  startColor,
                  endColor,
                  particle.progress,
                )!;
                canvas.drawCircle(
                  Offset.zero,
                  startSize,
                  Paint()
                    ..color = color.withOpacity(1 - particle.progress)
                    ..maskFilter = const MaskFilter.blur(
                      BlurStyle.normal,
                      3,
                    ),
                );
              });
            },
          ),
        ),
      );
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (size.isNaN) {
      return;
    }
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x * 0.54,
      orangePaint,
    );
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x * 0.5,
      redPaint,
    );
  }
}
