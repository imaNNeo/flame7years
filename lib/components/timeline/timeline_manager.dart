import 'package:flame/components.dart';
import 'package:flame7years/commits/contributions.dart';
import 'package:flame7years/components/animationphases/animation_phase.dart';
import 'package:flame7years/flame7game.dart';
import 'package:flutter/cupertino.dart';

mixin TimelineManager on Component {
  late Flame7Game game;

  late final double totalDuration;
  static const double eachStepDuration = 1.0;

  ContributionDataEntity get contributionData => game.communityData;

  ValueNotifier<int> currentDateIndexNotifier = ValueNotifier(-1);

  double _timePassed = 0;

  @override
  void onMount() {
    super.onMount();
    game = ancestors(includeSelf: true)
        .firstWhere((c) => c is Flame7Game) as Flame7Game;

    totalDuration = eachStepDuration * game.communityData.dates.length;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.currentAnimationPhase is! IdlePhase) {
      return;
    }
    _timePassed += dt;
    if (_timePassed >= eachStepDuration) {
      _timePassed = 0;
      if (currentDateIndexNotifier.value <
          game.communityData.dates.length - 1) {
        currentDateIndexNotifier.value++;
      }
    }
  }
}
