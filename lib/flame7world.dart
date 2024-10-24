import 'package:flame7years/components/big_flame_points.dart';

import 'commits/contributions.dart';
import 'components/background.dart';
import 'components/big_flame.dart';
import 'components/fire_area.dart';
import 'components/author/flame_author.dart';
import 'flame7game.dart';
import 'package:flame/components.dart';

class Flame7World extends World with HasGameRef<Flame7Game> {
  final Map<int, FireArea> _fireAreas = {};

  final Map<BigFlamePoint, double> _pointsIntensity = {};

  late final ContributionDataEntity communityData;
  int _fireAreaCounter = 0;

  late final BigFlame bigFlame;

  @override
  void onLoad() async {
    super.onLoad();
    communityData = loadCommunityData();
    add(Background());
    add(FlameAuthor(
      width: 60,
      position: Vector2(160, -300),
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
}
