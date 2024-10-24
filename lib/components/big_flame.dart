import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/particles.dart';
import 'package:flame7years/components/animationphases/animation_phase.dart';
import 'package:flame7years/components/animationphases/phase_observer.dart';
import 'package:flame7years/flame7world.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';

import 'big_flame_points.dart';

class BigFlame extends PositionComponent
    with ParentIsA<Flame7World>, PhaseObserver {
  static const _ratio = 994 / 321;
  static const keyName = 'main_large_logo';

  BigFlame({
    double width = 994,
  }) : super(
          size: Vector2(width, width / _ratio),
          anchor: Anchor.center,
          key: ComponentKey.named(keyName),
        );

  final showingPoints = allBigFlamePoints;
  late Timer _timer;
  List<bool> showingParts = List.generate(6, (i) => false);

  @override
  void onLoad() {
    super.onLoad();
    _timer = Timer(
      0.05,
      onTick: () {
        add(_particles());
        add(_particles());
        add(_particles());
      },
      repeat: true,
    );
  }

  Vector2 bigFlamePointToLocalPosition(BigFlamePoint point) => Vector2(
        point.x * size.x,
        point.y * size.y,
      );

  Vector2 bigFlamePointToWorldPosition(BigFlamePoint point) =>
      localToParent(bigFlamePointToLocalPosition(point));

  ParticleSystemComponent _particles() => ParticleSystemComponent(
        particle: Particle.generate(
          count: showingPoints.length ~/ 2,
          lifespan: (Random().nextDouble()) + 0.5,
          generator: (i) {
            final displacementThreshold = Vector2(5, 5);
            final randomDisplacement = Vector2(
              (Random().nextDouble() * displacementThreshold.x) -
                  displacementThreshold.x / 2,
              (Random().nextDouble() * displacementThreshold.y) -
                  displacementThreshold.y / 2,
            );
            final flamePoint = showingPoints.random();
            final position =
                bigFlamePointToLocalPosition(flamePoint) + randomDisplacement;
            final startColor = Color.lerp(
              orangeColor,
              redColor,
              Random().nextDouble(),
            );
            final endColor = Color.lerp(
              orangeColor2,
              redColor,
              Random().nextDouble(),
            );

            final particleSize = Random().nextDouble() * 3 + 2;

            final particleSizeTween = TweenSequence(
              [
                TweenSequenceItem(
                  tween: Tween<double>(begin: 0, end: particleSize),
                  weight: 0.2,
                ),
                TweenSequenceItem(
                  tween: Tween<double>(
                    begin: particleSize,
                    end: particleSize,
                  ),
                  weight: 0.6,
                ),
                TweenSequenceItem(
                  tween: Tween<double>(begin: particleSize, end: 0.8),
                  weight: 0.2,
                ),
              ],
            );

            const xAccelerationRange = 50;
            final flameAngle = Random().nextDouble() * pi * 2;

            final type = Random().nextDouble() < 0.003
                ? ParticleType.sparkle
                : [
                    ParticleType.circle,
                    ParticleType.arc,
                  ].random();
            final intensity =
                parent.getBigFlamePointIntensity(flamePoint) * 0.8;
            return AcceleratedParticle(
              acceleration: Vector2(
                    (Random().nextDouble() * xAccelerationRange) -
                        (xAccelerationRange / 2),
                    switch (type) {
                      ParticleType.circle || ParticleType.arc => -100,
                      ParticleType.sparkle => -900,
                    },
                  ) *
                  intensity,
              position: position,
              child: ComputedParticle(renderer: (canvas, particle) {
                if (intensity <= 0.1) {
                  return;
                }
                final color = Color.lerp(
                  startColor,
                  endColor,
                  particle.progress,
                )!;
                final size =
                    particleSizeTween.transform(particle.progress) * intensity;

                final reverseProgress = 1 - particle.progress;
                switch (type) {
                  case ParticleType.circle:
                    canvas.drawCircle(
                      Offset.zero,
                      size,
                      Paint()
                        ..color = color.withOpacity(
                          reverseProgress,
                        ),
                    );
                    break;
                  case ParticleType.arc:
                    canvas.drawArc(
                      Rect.fromCircle(
                        center: Offset.zero,
                        radius: particleSizeTween.transform(particle.progress),
                      ),
                      flameAngle,
                      1 * pi,
                      false,
                      Paint()
                        ..color = color.withOpacity(reverseProgress)
                        ..strokeWidth = size
                        ..style = PaintingStyle.stroke,
                    );
                    break;
                  case ParticleType.sparkle:
                    canvas.drawCircle(
                      Offset.zero,
                      2,
                      Paint()
                        ..color = orangeColor.withOpacity(
                          reverseProgress,
                        ),
                    );
                    break;
                }
              }),
            );
          },
        ),
      );

  @override
  void render(Canvas canvas) {
    final bool anythingToShow = showingParts.any((element) => element);
    if (anythingToShow) {
      canvas.save();
      canvas.scale(size.x / 994, size.y / 321);
    }
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final textPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    if (showingParts[0]) {
      // Logo
      final path1 = Path()
        ..moveTo(63.2734, 170.189)
        ..cubicTo(127.736, 105.195, 69.6115, 3.39708, 69.6115, 3.39708)
        ..cubicTo(73.1015, 3.29808, 178.8, 74.3971, 151.117, 209.767)
        ..cubicTo(142.52, 221.262, 130.629, 232.845, 114.392, 243.951)
        ..cubicTo(97.4615, 230.432, 81.4855, 213.231, 71.2065, 191.851)
        ..cubicTo(67.9045, 184.982, 65.2994, 177.695, 63.2734, 170.189);
      canvas.drawPath(path1, paint);

      final path2 = Path()
        ..moveTo(114.394, 243.948)
        ..cubicTo(201.871, 184.112, 163.181, 110.535, 163.181, 110.535)
        ..cubicTo(163.181, 110.535, 230.044, 197.073, 183.724, 282.158)
        ..cubicTo(183.724, 282.158, 142.26, 266.199, 114.394, 243.948);
      canvas.drawPath(path2, paint);

      final path3 = Path()
        ..moveTo(27.5888, 290.088)
        ..cubicTo(10.5508, 267.78, 2.14377, 238.535, 3.61877, 209.162)
        ..cubicTo(7.54177, 130.987, 64.9348, 47.1382, 64.9348, 47.1382)
        ..cubicTo(64.9348, 47.1382, 43.4788, 134.177, 71.2068, 191.851)
        ..cubicTo(98.4038, 248.421, 164.372, 275.138, 183.474, 282.498)
        ..cubicTo(162.634, 303.948, 134.605, 317.852, 102.365, 317.852)
        ..cubicTo(73.8058, 317.852, 47.6708, 307.389, 27.5888, 290.088);
      canvas.drawPath(path3, paint);
    }

    if (showingParts[1]) {
      // F
      final textPath1 = Path()
        ..moveTo(374.487, 148.903)
        ..lineTo(315.755, 148.903)
        ..cubicTo(301.949, 148.903, 297.27, 153.583, 297.27, 166.687)
        ..lineTo(297.27, 189.852)
        ..lineTo(358.342, 189.852)
        ..lineTo(356.002, 218.867)
        ..lineTo(297.27, 218.867)
        ..lineTo(297.27, 286.491)
        ..lineTo(264.745, 286.491)
        ..lineTo(264.745, 153.817)
        ..cubicTo(264.745, 129.248, 274.104, 119.888, 300.546, 119.888)
        ..lineTo(374.487, 119.888)
        ..lineTo(374.487, 148.903);
      canvas.drawPath(textPath1, textPaint);
    }

    if (showingParts[2]) {
      // L
      final textPath2 = Path()
        ..moveTo(502.993, 286.491)
        ..lineTo(453.386, 286.491)
        ..cubicTo(416.181, 286.491, 400.271, 273.154, 400.271, 240.161)
        ..lineTo(400.271, 119.888)
        ..lineTo(432.795, 119.888)
        ..lineTo(432.795, 240.161)
        ..cubicTo(432.795, 253.498, 437.943, 257.476, 453.386, 257.476)
        ..lineTo(502.993, 257.476)
        ..lineTo(502.993, 286.491);
      canvas.drawPath(textPath2, textPaint);
    }
    if (showingParts[3]) {
      // A
      final textPath3 = Path()
        ..moveTo(569.724, 264.73)
        ..lineTo(569.49, 264.73)
        ..lineTo(581.19, 226.355)
        ..lineTo(600.611, 164.347)
        ..lineTo(620.267, 230.333)
        ..lineTo(595.463, 230.333)
        ..lineTo(587.04, 257.71)
        ..lineTo(627.754, 257.71)
        ..lineTo(637.114, 286.491)
        ..lineTo(671.043, 286.491)
        ..lineTo(617.693, 133.928)
        ..cubicTo(613.481, 121.994, 608.099, 119.888, 600.611, 119.888)
        ..cubicTo(592.655, 119.888, 587.04, 122.696, 582.126, 133.928)
        ..lineTo(528.775, 286.491)
        ..lineTo(562.704, 286.491)
        ..lineTo(569.724, 264.73);
      canvas.drawPath(textPath3, textPaint);
    }
    if (showingParts[4]) {
      // M
      final textPath4 = Path()
        ..moveTo(822.25, 187.044)
        ..lineTo(792.299, 250.222)
        ..cubicTo(787.853, 258.88, 781.769, 262.858, 775.919, 262.858)
        ..cubicTo(769.835, 262.858, 764.22, 258.412, 759.774, 249.52)
        ..lineTo(729.355, 187.044)
        ..lineTo(729.355, 286.491)
        ..lineTo(696.83, 286.491)
        ..lineTo(696.83, 119.888)
        ..lineTo(728.887, 119.888)
        ..lineTo(775.919, 216.059)
        ..lineTo(822.718, 119.888)
        ..lineTo(854.775, 119.888)
        ..lineTo(854.775, 286.491)
        ..lineTo(822.25, 286.491)
        ..lineTo(822.25, 187.044);
      canvas.drawPath(textPath4, textPaint);
    }
    if (showingParts[5]) {
      // E
      final textPath5 = Path()
        ..moveTo(990.3, 286.491)
        ..lineTo(931.334, 286.491)
        ..cubicTo(894.129, 286.491, 880.557, 275.494, 880.557, 242.5)
        ..lineTo(880.557, 119.888)
        ..lineTo(990.3, 119.888)
        ..lineTo(990.3, 148.903)
        ..lineTo(913.083, 148.903)
        ..lineTo(913.083, 187.98)
        ..lineTo(967.135, 187.98)
        ..lineTo(964.795, 216.995)
        ..lineTo(913.083, 216.995)
        ..lineTo(913.083, 240.161)
        ..cubicTo(913.083, 253.498, 918.23, 257.476, 933.674, 257.476)
        ..lineTo(990.3, 257.476)
        ..lineTo(990.3, 286.491);
      canvas.drawPath(textPath5, textPaint);
    }
    if (anythingToShow) {
      canvas.restore();
    }

    for (final point in showingPoints) {
      final localPosition = bigFlamePointToLocalPosition(point);
      canvas.drawCircle(
        localPosition.toOffset(),
        4,
        Paint()
          ..color = Colors.red.withOpacity(
            parent.getBigFlamePointIntensity(point).clamp(0, 1),
          ),
      );
    }
  }

  Vector2 getRandomPointToFire() {
    // Step 1: Get the list of points and their intensities
    final pointsWithIntensities = allBigFlamePoints
        .map((point) => (point, parent.getBigFlamePointIntensity(point)))
        .toList();

    // Step 2: Find the minimum and maximum intensity
    double minIntensity = pointsWithIntensities.map((p) => p.$2).reduce(min);
    double maxIntensity = pointsWithIntensities.map((p) => p.$2).reduce(max);

    // Handle case where all intensities are the same
    if (minIntensity == maxIntensity) {
      // Select a random point if all intensities are the same
      return bigFlamePointToWorldPosition(
        pointsWithIntensities[Random().nextInt(pointsWithIntensities.length)]
            .$1,
      );
    }

    // Step 3: Calculate weights inversely proportional to intensity
    List<double> weights = pointsWithIntensities.map((p) {
      // Use the inverse of the intensity, scaled by the max and min
      return (maxIntensity - p.$2) + 1; // Add 1 to avoid zero weight
    }).toList();

    // Step 4: Normalize the weights (sum to 1)
    double totalWeight = weights.reduce((a, b) => a + b);
    List<double> normalizedWeights =
        weights.map((w) => w / totalWeight).toList();

    // Step 5: Generate a random value between 0 and 1
    double randomValue = Random().nextDouble();

    // Step 6: Select a point based on the weights
    double cumulativeWeight = 0;
    for (int i = 0; i < pointsWithIntensities.length; i++) {
      cumulativeWeight += normalizedWeights[i];
      if (randomValue < cumulativeWeight) {
        return bigFlamePointToWorldPosition(pointsWithIntensities[i].$1);
      }
    }

    // Fallback (this shouldn't be reached unless there's a numerical issue)
    return bigFlamePointToWorldPosition(pointsWithIntensities.last.$1);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }

  @override
  void onRemove() {
    _timer.stop();
    super.onRemove();
  }

  @override
  void onPhaseChanged(AnimationPhase phase) {
    switch (phase) {
      case StartPhase():
        break;
      case MovingToTheLogoLeftPhase():
        break;
      case ShowingTheFlameLogoPhase():
        Future.delayed(const Duration(milliseconds: 500)).then((_) {
          showingParts[0] = true;
        });
        break;
      case MovingToTheLogoRightPhase():
      case MovingToTheMainPositionPhase():
      case IdlePhase():
    }
  }
}

enum ParticleType { circle, arc, sparkle }
