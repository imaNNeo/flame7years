import 'package:flame/components.dart';
import 'package:flame7years/commits/contributions.dart';
import 'package:flame7years/components/animationphases/animation_phase.dart';
import 'package:flame7years/flame7world.dart';
import 'package:flutter/cupertino.dart';

mixin TimelineManager on Component {
  late Flame7World flame7World;

  late final double totalDuration;
  static const double eachStepDuration = 0.1;

  ContributionDataEntity get contributionData => flame7World.communityData;

  ValueNotifier<int> currentDateIndexNotifier = ValueNotifier(-1);

  double _timePassed = 0;

  @override
  void onMount() {
    super.onMount();
    flame7World = ancestors(includeSelf: true)
        .firstWhere((c) => c is Flame7World) as Flame7World;

    totalDuration = eachStepDuration * flame7World.communityData.dates.length;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (flame7World.currentPhase is! IdlePhase) {
      return;
    }
    _timePassed += dt;
    if (_timePassed >= eachStepDuration) {
      _timePassed = 0;
      if (currentDateIndexNotifier.value <
          flame7World.communityData.dates.length - 1) {
        currentDateIndexNotifier.value++;
      }
    }
  }
}
