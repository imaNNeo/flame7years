import 'package:flame/components.dart';
import 'package:flame7years/components/animationphases/phase_manager.dart';

import 'animation_phase.dart';

mixin PhaseObserver on Component {
  late PhaseManager _phaseManager;

  AnimationPhase? _previousAnimation;

  @override
  void onMount() {
    super.onMount();
    _phaseManager = ancestors(includeSelf: true)
        .firstWhere((c) => c is PhaseManager) as PhaseManager;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!_phaseManager.allPhasesFinished()) {
      final phase = _phaseManager.currentAnimationPhase;
      if (_previousAnimation == null) {
        onPhaseChanged(phase);
        _previousAnimation = phase;
      } else if (_previousAnimation.runtimeType != phase.runtimeType) {
        onPhaseChanged(phase);
        _previousAnimation = phase;
      }
    }
  }

  void onPhaseChanged(AnimationPhase phase);
}
