import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/particles.dart';
import 'package:flame7years/components/animationphases/animation_phase.dart';
import 'package:flame7years/components/animationphases/phase_observer.dart';
import 'package:flame7years/components/big_flame.dart';
import 'package:flame7years/components/flame_fireball.dart';
import 'package:flame7years/components/flame_small_logo.dart';
import 'package:flame7years/flame7game.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';

import 'effects/author_charging_shake_effect.dart';

class FlameAuthor extends PositionComponent
    with TapCallbacks, HasGameRef<Flame7Game>, PhaseObserver {
  static const _ratio = 89 / 122;

  static const _largeScale = 1.75;

  FlameAuthor({
    double width = 60,
    required Vector2 position,
    this.authorColor = Colors.white,
    this.isFirstAuthor = false,
  }) : super(
          size: Vector2(width, width / _ratio),
          position: position,
          anchor: const Anchor(0.5, 0.6352),
          priority: 10,
        );

  late final FlameAuthorEye _leftEye, _rightEye;
  final ui.Color authorColor;
  late double nextBlinkIn;

  late final FlameSmallLogo mainLogo;
  late final FlameSmallLogo overlayLogo;

  final bool isFirstAuthor;

  double moveSpeed = 100;
  Vector2? _movingTarget;

  bool get isMoving => _movingTarget != null;

  set overlayColor(Color color) {
    overlayLogo.color = color;
  }

  Color get overlayColor => overlayLogo.color;

  double getNextBlinkIn() => 4 + 4 * Random().nextDouble();

  late final Timer _testTimer;

  bool _lookingAtLeft = true;

  @override
  void onLoad() {
    super.onLoad();
    _testTimer = Timer(
      2.0,
      onTick: () {
        if (!game.world.allPhasesFinished()) {
          return;
        }
        _fire();
      },
      repeat: true,
      autoStart: true,
    );
    addAll([
      mainLogo = FlameSmallLogo(
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
    _runSpawnAnimation();
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
      _blink();
    }

    if (_movingTarget != null) {
      final diff = _movingTarget! - position;
      final distance = diff.length;
      if (distance < 1) {
        _movingTarget = null;
      } else {
        final direction = diff.normalized();
        final movement = direction * moveSpeed * dt;
        position += movement;
      }
    }
    if (!isMoving && game.world.allPhasesFinished()) {
      _refreshLookingDirection(position.x > 0);
    }
  }

  void _blink() {
    _leftEye.blink();
    _rightEye.blink();
    nextBlinkIn = getNextBlinkIn();
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

  void _refreshLookingDirection(bool lookingAtLeft) {
    _lookingAtLeft = lookingAtLeft;
    if (_lookingAtLeft && isFlippedHorizontally) {
      flipHorizontally();
    } else if (!_lookingAtLeft && !isFlippedHorizontally) {
      flipHorizontally();
    }
  }

  void _runSpawnAnimation() {
    add(ScaleEffect.to(
      Vector2.all(_largeScale),
      EffectController(
        duration: 0.6,
        curve: Curves.bounceOut,
      ),
      onComplete: () async {
        await Future.delayed(const Duration(milliseconds: 500));
        _blink();
      },
    ));
  }

  void _shakeAndReplicate() {
    add(SequenceEffect([
      AuthorReplicateAnimation1(EffectController(
        duration: 0.3,
      )),
      AuthorReplicateAnimation2(EffectController(
        duration: 0.2,
        atMaxDuration: 0.3,
      )),
    ]));
    add(
      ShakeEffect(
        controller: EffectController(
          duration: 0.6,
          startDelay: 0.3,
        ),
        intensity: 15,
      ),
    );
  }

  @override
  void onPhaseChanged(AnimationPhase phase) {
    switch (phase) {
      case StartPhase():
        position = phase.initialPosition;
        _refreshLookingDirection(true);
      case MovingToTheLogoLeftPhase():
        if (_movingTarget != phase.logoLeftPosition) {
          _movingTarget = phase.logoLeftPosition;
          moveSpeed = phase.moveSpeed;
        }
      case ShowingTheFlameLogoPhase():
        _shakeAndReplicate();
        break;
      case MovingToTheLogoRightPhase():
        if (_movingTarget != phase.logoRightPosition) {
          _movingTarget = phase.logoRightPosition;
          moveSpeed = phase.moveSpeed;
        }
        _refreshLookingDirection(false);
      case MovingToTheMainPositionPhase():
        if (_movingTarget != phase.mainPosition) {
          if (scale.y != 1.0) {
            add(ScaleEffect.to(
              Vector2(_lookingAtLeft ? 1.0 : -1.0, 1.0),
              EffectController(
                duration: 0.3,
              ),
            ));
          }
          _movingTarget = phase.mainPosition;
          moveSpeed = phase.moveSpeed;
        }
      case IdlePhase():
        _refreshLookingDirection(true);
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

class AuthorReplicateAnimation1 extends Effect with EffectTarget<FlameAuthor> {
  AuthorReplicateAnimation1(super.controller);

  late Color shapeStartColor;

  @override
  void onMount() {
    super.onMount();
    shapeStartColor = target.mainLogo.shapePaint.color;
  }

  @override
  void apply(double progress) {
    target.mainLogo.shapePaint.color = Color.lerp(
      shapeStartColor,
      shapeStartColor.withOpacity(0.0),
      progress,
    )!;
  }
}

class AuthorReplicateAnimation2 extends Effect with EffectTarget<FlameAuthor> {
  AuthorReplicateAnimation2(super.controller);

  @override
  void onStart() {
    target.mainLogo.shapePaint.style = PaintingStyle.stroke;
    target.mainLogo.shapePaint.strokeWidth = 0;
    target.mainLogo.shapePaint.color = Colors.white;
    super.onStart();
  }

  @override
  void apply(double progress) {
    target.mainLogo.shapePaint.strokeWidth = lerpDouble(0, 3, progress)!;
  }

  @override
  void onFinish() {
    target.mainLogo.shapePaint.style = PaintingStyle.fill;
    super.onFinish();
  }
}

class ShakeEffect extends Effect with EffectTarget<PositionProvider> {
  final double intensity; // How strong the shake should be
  final Random random = Random();

  late Vector2 initialPosition;

  ShakeEffect({
    required EffectController controller,
    this.intensity = 10.0, // Default intensity
  }) : super(controller);

  @override
  void onStart() {
    initialPosition = target.position.clone();
    super.onStart();
  }

  @override
  void apply(double progress) {
    // Use a sine function to make the shaking less abrupt and smoother
    final double shakeFactor = sin(progress * pi * 4) * (1 - progress);

    double offsetX = (random.nextDouble() * 2 - 1) * intensity * shakeFactor;
    double offsetY = (random.nextDouble() * 2 - 1) * intensity * shakeFactor;

    // Update the target's position with the shake offset
    target.position.setFrom(initialPosition + Vector2(offsetX, offsetY));
  }

  @override
  void reset() {
    super.reset();
    // Reset the position to avoid accumulating shake offsets
    target.position.setFrom(initialPosition);
  }
}
