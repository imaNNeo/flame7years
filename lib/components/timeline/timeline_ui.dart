import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame7years/commits/contributions.dart';
import 'package:flame7years/components/animationphases/animation_phase.dart';
import 'package:flame7years/components/animationphases/phase_observer.dart';
import 'package:flame7years/components/timeline/timeline_manager.dart';
import 'package:flame7years/components/timeline/timeline_observer.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';

class TimelineUI extends PositionComponent
    with TimelineObserver, PhaseObserver {
  static const boxWidth = 240.0;
  static const boxHeight = 24.0;

  TimelineUI({
    required super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2(boxWidth, boxHeight),
        );

  final Paint _boxBgPaint = Paint()
    ..color = orangeColor2
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;
  final Paint _boxFgPaint = Paint()
    ..color = orangeColor2
    ..style = PaintingStyle.fill;

  late RectangleComponent _progressBox;
  late TextComponent _yearText;
  bool isVisible = false;

  @override
  void onLoad() {
    super.onLoad();
    const topPadding = 10.0;
    add(RectangleComponent(
      size: Vector2(boxWidth, boxHeight),
      position: Vector2(0, topPadding),
      anchor: Anchor.topLeft,
      paint: _boxBgPaint,
    ));
    add(_progressBox = RectangleComponent(
      size: Vector2(0, boxHeight),
      position: Vector2(0, topPadding),
      anchor: Anchor.topLeft,
      paint: _boxFgPaint,
    ));
    add(_yearText = TextComponent(
      text: '1st year',
      position: Vector2(
        size.x / 2,
        -boxHeight * 0.2 + topPadding,
      ),
      anchor: Anchor.bottomCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: orangeColor2,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }

  @override
  void onDateChanged(
    ContributionDataEntity data,
    int dateIndex,
    int year,
    int month,
  ) {
    // An extra month
    final previousMonthNumber = month - 1;
    final currentYearProgress = month / 12;
    _yearText.text =
        '$year${year == 1 ? 'st' : year == 2 ? 'nd' : year == 3 ? 'rd' : 'th'} year';

    const stepDuration = TimelineManager.eachStepDuration;

    _progressBox.width = (previousMonthNumber / 12) * boxWidth;
    _progressBox.add(
      SizeEffect.to(
        Vector2(boxWidth * currentYearProgress, _progressBox.height),
        EffectController(duration: stepDuration),
      ),
    );
  }

  @override
  void renderTree(Canvas canvas) {
    if (isVisible) {
      super.renderTree(canvas);
    }
  }

  @override
  void onPhaseChanged(AnimationPhase phase) {
    isVisible = switch (phase) {
      IdlePhase() => true,
      _ => false,
    };
  }
}
