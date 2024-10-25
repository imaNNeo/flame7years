import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame7years/commits/contributions.dart';
import 'package:flame7years/components/author/flame_top_author.dart';
import 'package:flame7years/components/timeline/timeline_observer.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class FlameCommunityAuthor extends PositionComponent with TimelineObserver {
  final MultipleAuthorsEntity entity;

  FlameCommunityAuthor({
    required this.entity,
  }) : super(
          size: Vector2(200, 200),
          position: Vector2(270, 240),
        );

  final slots = [
    Vector2(40, 117),
    Vector2(85, 55),
    Vector2(150, 75),
    Vector2(110, 150),
  ];

  final List<FlameAuthorUI> _authors = [];
  late final List<String> namesList;
  late final TextComponent _name;
  int _currentShowingNameCounter = -1;

  void changeCommunityMemberName(String name) {
    _name.text = name;
  }

  @override
  void onLoad() {
    super.onLoad();
    namesList = List.of(entity.names);
    namesList.shuffle();
    add(TextComponent(
      text: '${namesList.length} community contributors',
      position: Vector2(size.x / 2, size.y + 6),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: orangeColor,
          fontSize: 14,
        ),
      ),
    ));
    add(_name = TextComponent(
      text: '',
      position: Vector2(size.x / 2, size.y + 26),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: orangeColor,
          fontSize: 18,
        ),
      ),
    ));
    _addAuthors();
  }

  void _addAuthors({double totalDuration = 1.0}) async {
    slots.shuffle();
    final eachDuration = totalDuration / slots.length;
    for (final slot in slots) {
      final author = FlameAuthorUI(
        position: slot,
        width: 50,
      );
      _authors.add(author);
      add(author);
      await Future.delayed(
        Duration(milliseconds: (eachDuration * 1000).toInt()),
      );
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      (size / 2).toOffset(),
      size.x / 2,
      Paint()
        ..color = orangeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    anchor = Anchor.center;
  }

  @override
  void onDateChanged(ContributionDataEntity data, int dateIndex) {
    final commitsForThisDay = entity.commits[dateIndex];
    if (commitsForThisDay > 0) {
      final fireSize = squeezeValue(
            commitsForThisDay.toDouble(),
            entity.minCommits.toDouble(),
            entity.maxCommits.toDouble(),
            1.0,
            2.0,
          ) *
          20;
      _authors.random().fire(fireSize);
    }
    _currentShowingNameCounter++;
    final showingName = namesList[_currentShowingNameCounter % namesList.length];
    changeCommunityMemberName(showingName);
  }
}
