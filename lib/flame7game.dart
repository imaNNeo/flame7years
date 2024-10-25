import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flame7years/components/animationphases/phase_manager.dart';
import 'package:flame7years/components/timeline/timeline_manager.dart';

import 'commits/contributions.dart';
import 'flame7world.dart';

class Flame7Game extends FlameGame<Flame7World>
    with TimelineManager, PhaseManager {
  Flame7Game()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 800,
            height: 800,
          ),
          world: Flame7World(),
        );

  late final ContributionDataEntity communityData;

  @override
  void onLoad() {
    super.onLoad();
    communityData = loadCommunityData();
  }
}
