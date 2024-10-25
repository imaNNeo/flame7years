import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import 'flame_top_author.dart';

class StartInfoText extends Component
    with ParentIsA<FlameTopAuthor>
    implements OpacityProvider {

  final double duration;

  StartInfoText({required this.duration});

  @override
  double get opacity =>
      (_text1.textRenderer as TextPaint).style.color?.opacity ?? 0.0;

  @override
  set opacity(double value) {
    _refreshTextsWithOpacity(value);
  }

  void _refreshTextsWithOpacity(double opacity) {
    _text1.textRenderer = TextPaint(
      style: TextStyle(
        color: _color1.withOpacity(opacity),
        fontSize: 16,
      ),
    );
  }

  late Color _color1;

  late TextBoxComponent _text1;

  @override
  void onLoad() {
    super.onLoad();
    _color1 = Colors.white;
    addAll([
      _text1 = TextBoxComponent(
        text: "To shape our flame, we need some fire! You’ll soon see fire orbs, each representing real contributions over the past 7 years. The size of each orb shows the contribution amount per month. I can’t do this alone—let’s hope others join in to keep the flame burning!",
        size: Vector2(370, 200),
        position: Vector2(-parent.size.x * 0.2, parent.size.y),
        anchor: Anchor.centerRight,
        boxConfig: const TextBoxConfig(timePerChar: 0.07),
      ),
    ]);
    _refreshTextsWithOpacity(0.0);
    add(SequenceEffect([
      OpacityEffect.to(1.0, EffectController(duration: 0.3, startDelay: 0.0)),
      OpacityEffect.to(0.0, EffectController(duration: 0.3, startDelay: duration - 0.6)),
      RemoveEffect(),
    ]));
  }
}
