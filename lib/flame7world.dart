import 'dart:ui';

import 'package:flame/effects.dart';
import 'package:flame7years/components/animationphases/phase_observer.dart';
import 'package:flame7years/components/big_flame_points.dart';

import 'commits/contributions.dart';
import 'components/animationphases/animation_phase.dart';
import 'components/animationphases/phase_manager.dart';
import 'components/background.dart';
import 'components/big_flame.dart';
import 'components/fire_area.dart';
import 'components/author/flame_author.dart';
import 'flame7game.dart';
import 'package:flame/components.dart';

class Flame7World extends World
    with HasGameRef<Flame7Game>, PhaseManager, PhaseObserver {
  final Map<int, FireArea> _fireAreas = {};

  final Map<BigFlamePoint, double> _pointsIntensity = {};

  late final ContributionDataEntity communityData;
  int _fireAreaCounter = 0;

  late final BigFlame bigFlame;

  late final FlameAuthor firstAuthor;
  RectangleComponent? _tempBottomRect;

  @override
  void onLoad() async {
    super.onLoad();
    communityData = loadCommunityData();
    add(Background());
    add(firstAuthor = FlameAuthor(
      position: Vector2(0, -400),
      isFirstAuthor: true,
      authorEntity: communityData.topAuthors.first,
    ));
    add(bigFlame = BigFlame(width: 500));
    for (final point in allBigFlamePoints) {
      _pointsIntensity[point] = 0.0;
    }
  }

  void addFireArea(Vector2 position, double radius, double initialIntensity) {
    final fireArea = FireArea(
      id: _fireAreaCounter++,
      position: position,
      radius: radius,
      initialIntensity: initialIntensity,
      containingPoints: [
        ..._pointsIntensity.keys.where((point) {
          final worldPoint = bigFlame.bigFlamePointToWorldPosition(point);
          return (worldPoint - position).length < radius;
        }),
      ],
      onIntensityChanged: _onIntensityChanged,
    );
    add(fireArea);
    _fireAreas[fireArea.id] = fireArea;
    _addIntensityToTheAffectedPoints(fireArea);
  }

  void _addIntensityToTheAffectedPoints(FireArea fireArea) {
    for (var point in fireArea.containingPoints) {
      _pointsIntensity[point] = _pointsIntensity[point]! + fireArea.intensity;
    }
  }

  void _onIntensityChanged(FireArea fireArea, double diff) {
    for (var point in fireArea.containingPoints) {
      _pointsIntensity[point] = _pointsIntensity[point]! + diff;
    }

    if (fireArea.intensity <= 0 && !fireArea.isRemoving) {
      _fireAreas.remove(fireArea.id);
      fireArea.removeFromParent();
    }
  }

  double getBigFlamePointIntensity(BigFlamePoint point) {
    return _pointsIntensity[point] ?? 0.0;
  }

  @override
  void onPhaseChanged(AnimationPhase phase) {
    final camera = gameRef.camera;
    switch (phase) {
      case StartPhase():
        camera.viewfinder.zoom = phase.initialCameraZoom;
        camera.moveTo(phase.initialPosition);
        camera.viewport.add(_tempBottomRect = RectangleComponent(
          position: Vector2(0, 600),
          size: Vector2(800, 200),
          paint: Paint()
            ..shader = Gradient.linear(
              const Offset(0, 0),
              const Offset(0, 200),
              [
                const Color(0x00000000),
                const Color(0xFF000000),
              ],
            ),
        ));
      case MovingToTheLogoLeftPhase():
        camera.follow(firstAuthor);
      case ShowingTheFlameLogoPhase():
        _tempBottomRect?.removeFromParent();
        camera.stop();
      case MovingToTheLogoRightPhase():
        camera.viewfinder.add(ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(duration: 1.0),
        ));
        camera.viewfinder.add(MoveToEffect(
          Vector2.zero(),
          EffectController(duration: 1.0),
        ));
      case MovingToTheMainPositionPhase():
      case IdlePhase():
    }
  }
}

class CameraZoomToEffect extends Effect with EffectTarget<CameraComponent> {
  final double targetZoom;
  late final double _initialZoom;

  CameraZoomToEffect(
    super.controller,
    this.targetZoom,
  );

  @override
  void onLoad() {
    _initialZoom = target.viewfinder.zoom;
    super.onLoad();
  }

  @override
  void apply(double progress) {
    target.viewfinder.zoom = lerpDouble(_initialZoom, targetZoom, progress)!;
  }
}
