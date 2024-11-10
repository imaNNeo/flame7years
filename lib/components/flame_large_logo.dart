import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class FlameLargeLogo extends PositionComponent with TapCallbacks {
  static const _ratio = 994 / 321;

  FlameLargeLogo({
    double width = 994,
  }) : super(
    size: Vector2(width, width / _ratio),
    anchor: Anchor.center,
  );

  List<Vector2> _points = [];

  @override
  void render(Canvas canvas) {
    // Scaling canvas to fit within the component's size
    canvas.save();
    canvas.scale(size.x / 994, size.y / 321);

    // Drawing the first path (outline flame-like structure)
    final path1Paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path1 = Path()
      ..moveTo(63.2734, 170.189)
      ..cubicTo(127.736, 105.195, 69.6115, 3.39708, 69.6115, 3.39708)
      ..cubicTo(73.1015, 3.29808, 178.8, 74.3971, 151.117, 209.767)
      ..cubicTo(142.52, 221.262, 130.629, 232.845, 114.392, 243.951)
      ..cubicTo(97.4615, 230.432, 81.4855, 213.231, 71.2065, 191.851)
      ..cubicTo(67.9045, 184.982, 65.2994, 177.695, 63.2734, 170.189);
    canvas.drawPath(path1, path1Paint);

    // Drawing the second path
    final path2 = Path()
      ..moveTo(114.394, 243.948)
      ..cubicTo(201.871, 184.112, 163.181, 110.535, 163.181, 110.535)
      ..cubicTo(163.181, 110.535, 230.044, 197.073, 183.724, 282.158)
      ..cubicTo(183.724, 282.158, 142.26, 266.199, 114.394, 243.948);
    canvas.drawPath(path2, path1Paint);

    // Drawing the third path
    final path3 = Path()
      ..moveTo(27.5888, 290.088)
      ..cubicTo(10.5508, 267.78, 2.14377, 238.535, 3.61877, 209.162)
      ..cubicTo(7.54177, 130.987, 64.9348, 47.1382, 64.9348, 47.1382)
      ..cubicTo(64.9348, 47.1382, 43.4788, 134.177, 71.2068, 191.851)
      ..cubicTo(98.4038, 248.421, 164.372, 275.138, 183.474, 282.498)
      ..cubicTo(162.634, 303.948, 134.605, 317.852, 102.365, 317.852)
      ..cubicTo(73.8058, 317.852, 47.6708, 307.389, 27.5888, 290.088);
    canvas.drawPath(path3, path1Paint);

    // Drawing the text paths (letters outlined in white)
    final textPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    // First text path (left block letters)
    final textPath1 = Path()
      ..moveTo(374.487, 148.903)
      ..lineTo(315.755, 148.903)
      ..cubicTo(301.949, 148.903, 297.27, 153.583, 297.27, 166.687)
      ..lineTo(297.27, 189.852)
      ..lineTo(358.342, 189.852)
      ..lineTo(356.002, 218.867)
      ..lineTo(297.27, 218.867)
      ..lineTo(297.27, 286.491)
      ..lineTo(264.745, 286.491)
      ..lineTo(264.745, 153.817)
      ..cubicTo(264.745, 129.248, 274.104, 119.888, 300.546, 119.888)
      ..lineTo(374.487, 119.888)
      ..lineTo(374.487, 148.903);
    canvas.drawPath(textPath1, textPaint);

    // Second text path (middle block letters)
    final textPath2 = Path()
      ..moveTo(502.993, 286.491)
      ..lineTo(453.386, 286.491)
      ..cubicTo(416.181, 286.491, 400.271, 273.154, 400.271, 240.161)
      ..lineTo(400.271, 119.888)
      ..lineTo(432.795, 119.888)
      ..lineTo(432.795, 240.161)
      ..cubicTo(432.795, 253.498, 437.943, 257.476, 453.386, 257.476)
      ..lineTo(502.993, 257.476)
      ..lineTo(502.993, 286.491);
    canvas.drawPath(textPath2, textPaint);

    // Third text path (block letters with a diagonal component)
    final textPath3 = Path()
      ..moveTo(569.724, 264.73)
      ..lineTo(569.49, 264.73)
      ..lineTo(581.19, 226.355)
      ..lineTo(600.611, 164.347)
      ..lineTo(620.267, 230.333)
      ..lineTo(595.463, 230.333)
      ..lineTo(587.04, 257.71)
      ..lineTo(627.754, 257.71)
      ..lineTo(637.114, 286.491)
      ..lineTo(671.043, 286.491)
      ..lineTo(617.693, 133.928)
      ..cubicTo(613.481, 121.994, 608.099, 119.888, 600.611, 119.888)
      ..cubicTo(592.655, 119.888, 587.04, 122.696, 582.126, 133.928)
      ..lineTo(528.775, 286.491)
      ..lineTo(562.704, 286.491)
      ..lineTo(569.724, 264.73);
    canvas.drawPath(textPath3, textPaint);

    // Fourth text path (block letters with a large 'L' shape)
    final textPath4 = Path()
      ..moveTo(822.25, 187.044)
      ..lineTo(792.299, 250.222)
      ..cubicTo(787.853, 258.88, 781.769, 262.858, 775.919, 262.858)
      ..cubicTo(769.835, 262.858, 764.22, 258.412, 759.774, 249.52)
      ..lineTo(729.355, 187.044)
      ..lineTo(729.355, 286.491)
      ..lineTo(696.83, 286.491)
      ..lineTo(696.83, 119.888)
      ..lineTo(728.887, 119.888)
      ..lineTo(775.919, 216.059)
      ..lineTo(822.718, 119.888)
      ..lineTo(854.775, 119.888)
      ..lineTo(854.775, 286.491)
      ..lineTo(822.25, 286.491)
      ..lineTo(822.25, 187.044);
    canvas.drawPath(textPath4, textPaint);

    // Fifth text path (final block letters)
    final textPath5 = Path()
      ..moveTo(990.3, 286.491)
      ..lineTo(931.334, 286.491)
      ..cubicTo(894.129, 286.491, 880.557, 275.494, 880.557, 242.5)
      ..lineTo(880.557, 119.888)
      ..lineTo(990.3, 119.888)
      ..lineTo(990.3, 148.903)
      ..lineTo(913.083, 148.903)
      ..lineTo(913.083, 187.98)
      ..lineTo(967.135, 187.98)
      ..lineTo(964.795, 216.995)
      ..lineTo(913.083, 216.995)
      ..lineTo(913.083, 240.161)
      ..cubicTo(913.083, 253.498, 918.23, 257.476, 933.674, 257.476)
      ..lineTo(990.3, 257.476)
      ..lineTo(990.3, 286.491);
    canvas.drawPath(textPath5, textPaint);

    // Restore canvas after scaling
    canvas.restore();

    // Drawing the points (taps)
    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    for (final point in _points) {
      canvas.drawCircle(point.toOffset(), 4, pointPaint);
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    _points.add(event.localPosition);
    print('Tapped at ${event.localPosition}');
  }

  @override
  void update(double dt) {
    // Update logic if needed
  }
}