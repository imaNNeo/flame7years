import 'package:flame/game.dart';

sealed class AnimationPhase {
  AnimationPhase({
    this.phaseProgress = 0.0,
    required this.duration,
  });

  double phaseProgress;

  final double duration;
}

// Show it on the top with a text or something like that
class StartPhase extends AnimationPhase {
  StartPhase({
    required this.initialPosition,
    required this.initialCameraZoom,
    required super.duration,
  });

  final Vector2 initialPosition;
  final double initialCameraZoom;
}

// Move the main author to the left
class MovingToTheLogoLeftPhase extends AnimationPhase {
  MovingToTheLogoLeftPhase({
    required this.logoLeftPosition,
    required this.moveSpeed,
    required super.duration,
  });

  final Vector2 logoLeftPosition;
  final double moveSpeed;
}

class ShowingTheFlameLogoPhase extends AnimationPhase {
  ShowingTheFlameLogoPhase({
    required super.duration,
  });
}

// Move the main author to the right
class MovingToTheLogoRightPhase extends AnimationPhase {
  MovingToTheLogoRightPhase({
    required this.logoRightPosition,
    required this.moveSpeed,
    required super.duration,
  });

  final Vector2 logoRightPosition;
  final double moveSpeed;
}

// Move the main author to the initial position
class MovingToTheMainPositionPhase extends AnimationPhase {
  MovingToTheMainPositionPhase({
    required this.mainPosition,
    required this.moveSpeed,
    required super.duration,
  });

  final Vector2 mainPosition;
  final double moveSpeed;
}

class ShowingStartInfoPhase extends AnimationPhase {
  ShowingStartInfoPhase({
    required super.duration,
  });
}

class IdlePhase extends AnimationPhase {
  IdlePhase({
    required super.duration,
  });
}
