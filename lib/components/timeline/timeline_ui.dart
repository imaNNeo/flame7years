import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame7years/commits/contributions.dart';
import 'package:flame7years/components/animationphases/animation_phase.dart';
import 'package:flame7years/components/animationphases/phase_observer.dart';
import 'package:flame7years/components/timeline/timeline_manager.dart';
import 'package:flame7years/components/timeline/timeline_observer.dart';
import 'package:flame7years/flame7game.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';

class TimelineUI extends PositionComponent
    with TimelineObserver, PhaseObserver, HasGameRef<Flame7Game> {
  static const boxWidth = 240.0;
  static const boxHeight = 24.0;

  TimelineUI({
    required super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2(boxWidth, boxHeight),
        );

  final Paint _boxBgPaint = Paint()
    ..color = Colors.transparent
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;
  final Paint _boxFgPaint = Paint()
    ..color = Colors.transparent
    ..style = PaintingStyle.fill;

  late RectangleComponent _progressBox;
  late TextComponent _yearText;
  bool isVisible = false;

  TextComponent? _yearNumberText;

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
      text: 'st year',
      position: Vector2(
        size.x / 2,
        -boxHeight * 0.2 + topPadding,
      ),
      anchor: Anchor.bottomCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.transparent,
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
        '${year == 1 ? 'st' : year == 2 ? 'nd' : year == 3 ? 'rd' : 'th'} year';

    const stepDuration = TimelineManager.eachStepDuration;

    _progressBox.width = (previousMonthNumber / 12) * boxWidth;
    _progressBox.add(
      SizeEffect.to(
        Vector2(boxWidth * currentYearProgress, _progressBox.height),
        EffectController(duration: stepDuration),
      ),
    );
    _tryToShowNewYearAnimation(year);
  }

  void _tryToShowNewYearAnimation(int year) {
    bool shouldShow = false;
    if (_yearNumberText == null) {
      shouldShow = true;
    } else {
      final currentYear = int.parse(_yearNumberText!.text);
      shouldShow = currentYear != year;
    }

    if (!shouldShow) {
      return;
    }

    _yearNumberText?.removeFromParent();

    final mainPosition =
        _yearText.positionOfAnchor(Anchor.bottomLeft) - Vector2(8, 14);
    const mainScale = 0.12;
    const duration = 0.6;
    const startDelay = 0.6;
    final centerPos = Vector2(game.size.x * 0.14, game.size.y * 0.45);
    add(
      _yearNumberText = TextComponent(
        text: year.toString(),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: orangeColor2,
            fontSize: 200,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 12,
              ),
            ],
          ),
        ),
        position: centerPos,
        scale: Vector2.all(1.0),
        children: [
          ScaleEffect.to(
            Vector2.all(mainScale),
            EffectController(
              duration: duration,
              startDelay: startDelay,
            ),
          ),
          MoveToEffect(
            mainPosition,
            EffectController(
              duration: duration,
              startDelay: startDelay,
              onMax: () {
                _boxBgPaint.color = orangeColor2;
                _boxFgPaint.color = orangeColor2;
                _yearText.textRenderer = TextPaint(
                  style: const TextStyle(
                    color: orangeColor2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ],
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
      ShowFirstYearAnimationPhase() || IdlePhase() => true,
      _ => false,
    };
    if (phase is ShowFirstYearAnimationPhase) {
      Future.delayed(const Duration(seconds: 1), () {
        _tryToShowNewYearAnimation(1);
      });
    }
  }
}
