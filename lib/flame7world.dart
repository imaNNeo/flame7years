import 'commits/contributions.dart';
import 'components/background.dart';
import 'components/big_flame.dart';
import 'components/fire_area.dart';
import 'components/flame_author.dart';
import 'flame7game.dart';
import 'package:flame/components.dart';

class Flame7World extends World with HasGameRef<Flame7Game> {
  final Map<int, FireArea> _fireAreas = {};

  late final ContributionDataEntity communityData;
  int _fireAreaCounter = 0;

  @override
  void onLoad() async {
    super.onLoad();
    communityData = loadCommunityData();
    add(Background());
    add(FlameAuthor(
      width: 60,
      position: Vector2(160, -300),
    ));
    add(BigFlame(width: 500));
  }

  void addFireArea(Vector2 position, double radius, double initialIntensity) {
    final fireArea = FireArea(
      id: _fireAreaCounter++,
      position: position,
      radius: radius,
      initialIntensity: initialIntensity,
      onIntensityZero: _onIntensityZero,
    );
    add(fireArea);
    _fireAreas[fireArea.id] = fireArea;
  }

  void _onIntensityZero(FireArea fireArea) {
    _fireAreas.remove(fireArea.id);
    fireArea.removeFromParent();
  }
}
