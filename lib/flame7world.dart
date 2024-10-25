import 'dart:math';
import 'dart:ui';

import 'package:flame/effects.dart';
import 'package:flame7years/components/animationphases/phase_observer.dart';
import 'package:flame7years/components/big_flame_points.dart';
import 'package:flame7years/components/timeline/timeline_observer.dart';

import 'commits/contributions.dart';
import 'components/animationphases/animation_phase.dart';
import 'components/author/flame_top_author.dart';
import 'components/background.dart';
import 'components/big_flame.dart';
import 'components/fire_area.dart';
import 'components/flame_community_author.dart';
import 'components/timeline/timeline_ui.dart';
import 'flame7game.dart';
import 'package:flame/components.dart';

class Flame7World extends World
    with HasGameRef<Flame7Game>, PhaseObserver, TimelineObserver {
  final Map<int, FireArea> _fireAreas = {};

  final Map<BigFlamePoint, double> _pointsIntensity = {};

  ContributionDataEntity get communityData => game.communityData;
  int _fireAreaCounter = 0;

  late final BigFlame bigFlame;

  final Map<String, FlameTopAuthor> topAliveAuthors = {};
  late final String firstAuthorName;

  RectangleComponent? _tempBottomRect;

  FlameTopAuthor get firstAuthor => topAliveAuthors[firstAuthorName]!;

  FlameCommunityAuthor? flameCommunityAuthor;

  List<Vector2> topAuthorsAvailableSlots = [
    Vector2(220, -225),
    Vector2(90, -300),
    Vector2(-90, -300),
    Vector2(-230, -245),
    Vector2(-350, -200),
    Vector2(-350, 190),
    Vector2(-240, 280),
    Vector2(-100, 340),
    Vector2(100, 340),
  ];
  late TimelineUI timelineUI;

  @override
  void onLoad() async {
    super.onLoad();
    add(Background());
    final firstAuthor = communityData.topAuthors.first;
    firstAuthorName = firstAuthor.name;
    add(topAliveAuthors[firstAuthorName] = FlameTopAuthor(
      position: Vector2(0, -400),
      isFirstAuthor: true,
      authorEntity: firstAuthor,
    ));
    add(bigFlame = BigFlame(width: 500));
    for (final point in allBigFlamePoints) {
      _pointsIntensity[point] = 0.0;
    }
    game.camera.moveTo(topAliveAuthors[firstAuthorName]!.position);
    game.camera.viewport.add(
      timelineUI = TimelineUI(
        position: Vector2(
          game.size.x / 2,
          TimelineUI.boxHeight * 6,
        ),
      ),
    );
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
          Vector2.all(0.8),
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

  @override
  void onDateChanged(
    ContributionDataEntity data,
    int dateIndex,
    int year,
    int month,
  ) {
    _tryToAddNewAuthors(data, dateIndex);
    _tryToAddCommunityAuthor(data, dateIndex);
  }

  void _tryToAddNewAuthors(ContributionDataEntity data, int dateIndex) {
    if (topAliveAuthors.length == data.topAuthors.length) {
      return;
    }

    for (final author in data.topAuthors) {
      if (topAliveAuthors.containsKey(author.name)) {
        continue;
      }
      final nextDayCommits =
          author.commits[min(dateIndex + 1, author.commits.length - 1)];
      if (nextDayCommits <= 0) {
        return;
      }
      final slot = topAuthorsAvailableSlots.removeAt(
        Random().nextInt(topAuthorsAvailableSlots.length),
      );
      add(topAliveAuthors[author.name] = FlameTopAuthor(
        position: slot,
        authorEntity: author,
      ));
    }
  }

  void _tryToAddCommunityAuthor(ContributionDataEntity data, int dateIndex) {
    if (flameCommunityAuthor != null) {
      return;
    }

    final author = data.community;
    final nextDayCommits =
        author.commits[min(dateIndex + 1, author.commits.length - 1)];
    if (nextDayCommits <= 0) {
      return;
    }
    add(flameCommunityAuthor = FlameCommunityAuthor(
      entity: data.community,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    timelineUI.position = Vector2(game.size.x / 2, 40);
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
