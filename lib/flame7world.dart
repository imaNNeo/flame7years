import 'package:flame7years/components/flame_large_logo.dart';
import 'commits/contributions.dart';
import 'components/background.dart';
import 'components/fire_area.dart';
import 'components/flame_author.dart';
import 'flame7game.dart';
import 'package:flame/components.dart';

class Flame7World extends World with HasGameRef<Flame7Game> {
  final List<FireArea> _fireAreas = [];

  late final ContributionDataEntity communityData;

  @override
  void onLoad() async {
    super.onLoad();
    communityData = loadCommunityData();
    add(Background());
    add(FlameAuthor(
      width: 60,
      position: Vector2(160, -300),
    ));
    add(FlameLargeLogo(width: 500));
  }

  void addFireArea(Vector2 position, double radius) {
    final fireArea = FireArea(
      position: position,
      radius: radius,
    );
    add(fireArea);
    _fireAreas.add(fireArea);
  }
}
