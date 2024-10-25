import 'package:flame/components.dart';
import 'animation_phase.dart';

mixin PhaseManager on Component {
  late final List<AnimationPhase> allPhases;

  double allPhasesTimer = 0.0;
  double currentPhaseTimer = 0.0;
  int currentPhaseIndex = 0;

  bool allPhasesFinished() => currentPhaseIndex >= allPhases.length;

  AnimationPhase get currentAnimationPhase => allPhases[currentPhaseIndex];

  @override
  void onLoad() {
    super.onLoad();
    allPhases = [
      StartPhase(
        initialPosition: Vector2(0, -400),
        duration: 5,
        initialCameraZoom: 1.5,
      ),
      MovingToTheLogoLeftPhase(
        logoLeftPosition: Vector2(-198.5, 21.4),
        duration: 3.0,
        moveSpeed: 200,
      ),
      ShowingTheFlameLogoPhase(
        duration: 1.5,
      ),
      MovingToTheLogoRightPhase(
        logoRightPosition: Vector2(330, 21.4),
        duration: 2.5,
        moveSpeed: 200,
      ),
      MovingToTheMainPositionPhase(
        duration: 3.0,
        mainPosition: Vector2(350, -160),
        moveSpeed: 100,
      ),
      ShowingStartInfoPhase(
        duration: 20,
      ),
      IdlePhase(duration: 999999),
    ];
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (allPhasesFinished()) {
      return;
    }
    final currentPhase = allPhases[currentPhaseIndex];
    if (currentPhaseTimer >= currentPhase.duration) {
      currentPhaseIndex++;
      if (currentPhaseIndex >= allPhases.length) {
        return;
      }
      currentPhaseTimer = 0.0;
    }

    currentPhaseTimer += dt;
    allPhasesTimer += dt;
  }
}
