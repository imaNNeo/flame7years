import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

const orangeColor = Color(0xFFFEBC1E);
const orangeColor2 = Color(0xFFFF8835);
const redColor = Color(0xFFEA192F);

void main() {
  runApp(GameWidget(
    game: Flame7Game(),
    backgroundBuilder: (context) {
      return const BackgroundGrid();
    },
  ));
}

class Flame7Game extends FlameGame {
  Flame7Game()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 800,
            height: 800,
          ),
        );
}

class BackgroundGrid extends StatelessWidget {
  const BackgroundGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            child: GridPaper(
              color: orangeColor.withOpacity(0.3),
              divisions: 1,
              subdivisions: 1,
              interval: 40,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.black12,
                  Colors.black,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
