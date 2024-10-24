import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/particles.dart';
import 'package:flame7years/components/big_flame.dart';
import 'package:flame7years/components/flame_fireball.dart';
import 'package:flame7years/components/flame_small_logo.dart';
import 'package:flame7years/flame7game.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';

import 'effects/author_charging_shake_effect.dart';

class FlameAuthor extends PositionComponent
    with TapCallbacks, HasGameRef<Flame7Game> {
  static const _ratio = 89 / 122;

  FlameAuthor({
    double width = 89,
    required Vector2 position,
    this.authorColor = Colors.white,
  }) : super(
          size: Vector2(width, width / _ratio),
          position: position,
          anchor: const Anchor(0.5, 0.6352),
          priority: 10,
        );

  late final FlameAuthorEye _leftEye, _rightEye;
  final ui.Color authorColor;
  late double nextBlinkIn;

  late final FlameSmallLogo overlayLogo;

  set overlayColor(Color color) {
    overlayLogo.color = color;
  }

  Color get overlayColor => overlayLogo.color;

  double getNextBlinkIn() => 4 + 4 * Random().nextDouble();

  late final Timer _testTimer;

  @override
  void onLoad() {
    super.onLoad();
    _testTimer = Timer(
      2.0,
      onTick: () {
        _fire();
      },
      repeat: true,
      autoStart: true,
    );
    addAll([
      FlameSmallLogo(
        color: authorColor,
        width: size.x,
        anchor: Anchor.topLeft,
      ),
      overlayLogo = FlameSmallLogo(
        color: Colors.transparent,
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
    _fire();
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _testTimer.update(dt);
    _leftEye.position = Vector2(size.x * 0.22, size.y * 0.685);
    _rightEye.position = Vector2(size.x * 0.44, size.y * 0.685);
    nextBlinkIn -= dt;
    if (nextBlinkIn <= 0) {
      _leftEye.blink();
      _rightEye.blink();
      nextBlinkIn = getNextBlinkIn();
    }
  }

  void _fire() {
    final bigFlame = game.findByKeyName(BigFlame.keyName) as BigFlame;
    final targetPos = bigFlame.getRandomPointToFire();
    add(AuthorShakeAndReleaseEffect(
      onReleased: () {
        _burnPhosphorus();
        game.world.add(FlameFireball(
          position: absolutePositionOfAnchor(const Anchor(0.5, 0.9)),
          target: targetPos,
          size: Vector2.all(22),
          speed: 200,
          priority: priority + 1,
        ));
      },
      chargeDuration: 1.0,
    ));
  }

  void _burnPhosphorus() {
    final particlePositionXRange = size.x;
    const startColor = redColor;
    const endColor = orangeColor;
    game.world.add(ParticleSystemComponent(
      priority: priority + 1,
      position: absolutePosition,
      particle: Particle.generate(
        count: 10,
        lifespan: 0.6,
        generator: (i) => AcceleratedParticle(
          position: Vector2(
            (Random().nextDouble() * particlePositionXRange) -
                (particlePositionXRange / 2),
            -size.y * 0.3,
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
