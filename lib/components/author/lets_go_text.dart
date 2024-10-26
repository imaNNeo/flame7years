import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';

import 'flame_top_author.dart';

class LetsGoText extends Component
    with ParentIsA<FlameTopAuthor>
    implements OpacityProvider {
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
    _text2.textRenderer = TextPaint(
      style: TextStyle(
        color: _color2.withOpacity(opacity),
        fontSize: 14.6,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  late Color _color1, _color2;

  late TextComponent _text1, _text2;

  @override
  void onLoad() {
    super.onLoad();
    _color1 = Colors.white;
    _color2 = orangeColor;
    addAll([
      _text1 = TextComponent(
        text: "Hey, let's build",
        position: Vector2(-parent.size.x / 2 - 0, parent.size.y * 0.78 - 10),
        anchor: Anchor.centerRight,
      ),
      _text2 = TextComponent(
        text: "something hot!",
        position: Vector2(-parent.size.x / 2, parent.size.y * 0.78 + 10),
        anchor: Anchor.centerRight,
      ),
    ]);
    _refreshTextsWithOpacity(0.0);
    add(SequenceEffect([
      OpacityEffect.to(1.0, EffectController(duration: 0.3)),
      OpacityEffect.to(0.0, EffectController(duration: 0.3, startDelay: 2.5)),
      RemoveEffect(),
    ]));
  }
}
