import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/particles.dart';
import 'package:flame7years/main.dart';
import 'package:flutter/material.dart';

class FlameLargeLogo extends PositionComponent {
  static const _ratio = 994 / 321;

  FlameLargeLogo({
    double width = 994,
  }) : super(
          size: Vector2(width, width / _ratio),
          anchor: Anchor.center,
        );

  final logoLeftPoints = [
    Vector2(0.13428372739916553, 0.9122932183415006),
    Vector2(0.044323713490959676, 0.6145872057504582),
    Vector2(0.06886300417246173, 0.8253232249706455),
    Vector2(0.0502955493741307, 0.348482174966096),
    Vector2(0.019462795549374107, 0.7780294217046002),
    Vector2(0.07589534075104314, 0.7042758525816832),
    Vector2(0.03347531293463146, 0.5503085476973472),
    Vector2(0.09203755215577189, 0.9410409598828418),
    Vector2(0.104346314325452, 0.8048929479763779),
    Vector2(0.05482440890125179, 0.9085786225243611),
    Vector2(0.025834492350486755, 0.6713828374473025),
    Vector2(0.05136474269819189, 0.7680161634149195),
    Vector2(0.03952538247566065, 0.45634004046811283),
    Vector2(0.09788769123783027, 0.8911630899613949),
    Vector2(0.13505737134909596, 0.8622000095321036),
    Vector2(0.05318150208623086, 0.6962813963665354),
    Vector2(0.08953407510431156, 0.7911381765085634),
    Vector2(0.1632823365785814, 0.9006649183921942),
    Vector2(0.039725312934631406, 0.8512984783296285),
    Vector2(0.016011821974965187, 0.6124068995099632),
    Vector2(0.07806849791376913, 0.9160078141586402),
    Vector2(0.055485048678720374, 0.5618830129246659),
    Vector2(0.11648991655076497, 0.8873408247002801),
    Vector2(0.05545897079276773, 0.22116305746558684),
    Vector2(0.02391342141863703, 0.48654131950311746),
    Vector2(0.04800069541029205, 0.30463379390725254),
    Vector2(0.036526425591098755, 0.40805029484529814),
  ];

  final logoMiddlePoints = [
    Vector2(0.11211752433936022, 0.747101373922764),
    Vector2(0.06805458970792767, 0.5559881108670313),
    Vector2(0.11628129346314324, 0.5745610899527293),
    Vector2(0.135596314325452, 0.39103852269723893),
    Vector2(0.10339012517385254, 0.26035473507250867),
    Vector2(0.08378824756606394, 0.0735751671367726),
    Vector2(0.10423331015299021, 0.46191193419382204),
    Vector2(0.09759214186369956, 0.6505757173991222),
    Vector2(0.1282510431154381, 0.27715116833261844),
    Vector2(0.13547461752433929, 0.4975236027885737),
    Vector2(0.10895340751043113, 0.17820294931953776),
    Vector2(0.09128129346314325, 0.543390785921949),
    Vector2(0.11379520166898464, 0.3589799457536643),
    Vector2(0.12075799721835881, 0.684841517944185),
    Vector2(0.10298157162726006, 0.41881723924280423),
    Vector2(0.14232440890125173, 0.5628520379204415),
    Vector2(0.09953929068150211, 0.12259168150641918),
    Vector2(0.12701668984700967, 0.4615350911399097),
    Vector2(0.0921853268428373, 0.6143718668625078),
  ];

  final logoRightPoints = [
    Vector2(0.1245827538247566, 0.7658358571744245),
    Vector2(0.17997218358831713, 0.6827419637866711),
    Vector2(0.18566585535465924, 0.544440563000706),
    Vector2(0.17584318497913767, 0.831810308970143),
    Vector2(0.15990959666203058, 0.7803443147500639),
    Vector2(0.17800764951321282, 0.6173327765718223),
    Vector2(0.15477225312934634, 0.7023916373121202),
    Vector2(0.1885952712100139, 0.7562263592996502),
    Vector2(0.1752955493741307, 0.4075926997084044),
    Vector2(0.1836404728789986, 0.4873757576939243),
    Vector2(0.14412378303198886, 0.7731573793647287),
    Vector2(0.16546418636995822, 0.6507910562870725),
  ];

  final logoFPoints = [
    Vector2(0.2898470097357441, 0.6400510292505598),
    Vector2(0.2898470097357441, 0.6400510292505598),
    Vector2(0.2726877607788595, 0.8745550782282419),
    Vector2(0.3312673852573018, 0.6307107049857237),
    Vector2(0.36486439499304596, 0.4071620219325037),
    Vector2(0.3154554937413073, 0.4190325781307544),
    Vector2(0.28762169680111266, 0.42753846420478403),
    Vector2(0.27956363004172463, 0.512247399252163),
    Vector2(0.2848574408901252, 0.7335888587038938),
    Vector2(0.27813803894297634, 0.5961757308307228),
    Vector2(0.28542246175243396, 0.83579407839722),
    Vector2(0.27423504867872045, 0.6894982213961067),
    Vector2(0.31183066759388034, 0.6418814097981359),
    Vector2(0.34324582753824756, 0.42339319061174446),
  ];

  final logoLPoints = [
    Vector2(0.4130824061196105, 0.41014984900281176),
    Vector2(0.4186717663421418, 0.5705504031646584),
    Vector2(0.4181067454798332, 0.739403008678547),
    Vector2(0.4918289290681502, 0.8374360374178398),
    Vector2(0.4426721140472879, 0.8525366769353417),
    Vector2(0.4222270514603616, 0.8148792889050644),
    Vector2(0.42068845618915157, 0.6565782889007318),
    Vector2(0.4225921418636996, 0.48301514521293426),
    Vector2(0.4688716968011126, 0.8645418199385612),
  ];

  final logoAPoints = [
    Vector2(0.5988525730180807, 0.7965485660683105),
    Vector2(0.6357180111265647, 0.7749070078293234),
    Vector2(0.6038160639777468, 0.4221011572840439),
    Vector2(0.5801894993045897, 0.6504142132331594),
    Vector2(0.5547287899860918, 0.8616078275902408),
    Vector2(0.5688716968011126, 0.7268864358164465),
    Vector2(0.5859266342141863, 0.5059218194186281),
    Vector2(0.6254259388038943, 0.6100650891035053),
    Vector2(0.6606745479833102, 0.8705174740791769),
    Vector2(0.6394558414464533, 0.7030107366149765),
    Vector2(0.5558327538247566, 0.805781220889172),
    Vector2(0.5824321974965231, 0.5909806801589259),
    Vector2(0.6164986091794159, 0.5093672416258302),
    Vector2(0.657510431154381, 0.810087998648174),
    Vector2(0.6150904033379694, 0.745055654487238),
    Vector2(0.5625, 0.7653244273155427),
    Vector2(0.5967489568845619, 0.47189827512250926),
    Vector2(0.6154989568845618, 0.46753766264151925),
    Vector2(0.6244610570236439, 0.5686392705341011),
    Vector2(0.6366828929068149, 0.6785966901936316),
    Vector2(0.6441672461752435, 0.8538556276240366),
  ];

  final logoMPoints = [
    Vector2(0.713047635605007, 0.40697360040554775),
    Vector2(0.7781728094575799, 0.737599545491965),
    Vector2(0.8438977746870653, 0.4567976356050066),
    Vector2(0.7240090403337968, 0.5093403242648364),
    Vector2(0.7149078581363004, 0.8498718581969591),
    Vector2(0.8469662726008343, 0.848741329035221),
    Vector2(0.7182719054242003, 0.6788389464425755),
    Vector2(0.7582406119610571, 0.6163906689370402),
    Vector2(0.8045462447844229, 0.5912767711298572),
    Vector2(0.8369871349095965, 0.5319239901386056),
    Vector2(0.8447583449235049, 0.690009651254988),
    Vector2(0.818289290681502, 0.503553091651177),
    Vector2(0.7437934631432545, 0.530389700561961),
    Vector2(0.7130997913769124, 0.5736189823179475),
    Vector2(0.7171331710709319, 0.7678277418879631),
    Vector2(0.7125434631432545, 0.4746976806658606),
    Vector2(0.8406728094575799, 0.6047623689877338),
    Vector2(0.8406467315716273, 0.7873966633304305),
    Vector2(0.7651077885952712, 0.6912478498607011),
    Vector2(0.7998348400556327, 0.6668876381613438),
    Vector2(0.8310413769123783, 0.420701454512368),
    Vector2(0.7330059109874826, 0.45854726406960133),
    Vector2(0.7172548678720444, 0.6422582528520483),
    Vector2(0.8342750347705146, 0.47811618551206864),
    Vector2(0.7528251043115438, 0.5843320919934664),
    Vector2(0.7932719054242002, 0.7035221664738582),
    Vector2(0.836317802503477, 0.7416640670020231),
    Vector2(0.7152381780250348, 0.7480703989185391),
  ];

  final logoEPoints = [
    Vector2(0.9017732962447844, 0.42255875242093766),
    Vector2(0.9074061196105702, 0.6803194012972325),
    Vector2(0.9574061196105702, 0.8458073366869003),
    Vector2(0.9044332406119611, 0.8074231799097915),
    Vector2(0.948087621696801, 0.6330525153921809),
    Vector2(0.9832319193324061, 0.4203515288194488),
    Vector2(0.9568150208623087, 0.4139451969029328),
    Vector2(0.8992350486787204, 0.5381688178891587),
    Vector2(0.9046940194714882, 0.6230930918244878),
    Vector2(0.9330841446453407, 0.8521867512424229),
    Vector2(0.9852312239221139, 0.8594006039887523),
    Vector2(0.9025730180806677, 0.7534538711172923),
    Vector2(0.9061456884561891, 0.4876180139428679),
    Vector2(0.9317020166898469, 0.40840022053821706),
    Vector2(0.934866133518776, 0.6391896736987596),
    Vector2(0.9214012517385256, 0.6116262960411437),
    Vector2(0.9219836578581362, 0.8434655262804431),
    Vector2(0.9760778859527119, 0.8375167895008209),
    Vector2(0.8968184979137691, 0.6694986221777387),
    Vector2(0.8953929068150207, 0.4653304390400304),
  ];

  final showingPoints = <Vector2>[];
  late Timer _timer;

  double intensity = 1.0;

  @override
  void onLoad() {
    super.onLoad();
    showingPoints.addAll([
      ...logoLeftPoints,
      ...logoMiddlePoints,
      ...logoRightPoints,
      ...logoFPoints,
      ...logoLPoints,
      ...logoAPoints,
      ...logoMPoints,
      ...logoEPoints,
    ]);

    _timer = Timer(
      0.05,
      onTick: () {
        if (intensity == 0) {
          return;
        }
        add(_particles());
        add(_particles());
        add(_particles());
      },
      repeat: true,
    );
  }

  ParticleSystemComponent _particles() => ParticleSystemComponent(
        particle: Particle.generate(
          count: showingPoints.length ~/ 2,
          lifespan: (Random().nextDouble()) + 0.5,
          generator: (i) {
            final displacementThreshold = Vector2(0.02, 0.02);
            final randomDisplacement = Vector2(
              (Random().nextDouble() * displacementThreshold.x) -
                  displacementThreshold.x / 2,
              (Random().nextDouble() * displacementThreshold.y) -
                  displacementThreshold.y / 2,
            );
            final point = showingPoints.random() + randomDisplacement;
            final startColor = Color.lerp(
              orangeColor,
              redColor,
              Random().nextDouble(),
            );
            final endColor = Color.lerp(
              orangeColor2,
              redColor,
              Random().nextDouble(),
            );

            final particleSize = Random().nextDouble() * 3 + 2;

            final particleSizeTween = TweenSequence(
              [
                TweenSequenceItem(
                  tween: Tween<double>(begin: 0, end: particleSize),
                  weight: 0.2,
                ),
                TweenSequenceItem(
                  tween: Tween<double>(
                    begin: particleSize,
                    end: particleSize,
                  ),
                  weight: 0.6,
                ),
                TweenSequenceItem(
                  tween: Tween<double>(begin: particleSize, end: 0.8),
                  weight: 0.2,
                ),
              ],
            );

            const xAccelerationRange = 50;
            final flameAngle = Random().nextDouble() * pi * 2;

            final type = Random().nextDouble() < 0.003
                ? ParticleType.sparkle
                : [
                    ParticleType.circle,
                    ParticleType.arc,
                  ].random();
            return AcceleratedParticle(
              acceleration: Vector2(
                    (Random().nextDouble() * xAccelerationRange) -
                        (xAccelerationRange / 2),
                    switch (type) {
                      ParticleType.circle || ParticleType.arc => -100,
                      ParticleType.sparkle => -900,
                    },
                  ) *
                  intensity,
              position: Vector2(point.x * size.x, point.y * size.y),
              child: ComputedParticle(renderer: (canvas, particle) {
                final color = Color.lerp(
                  startColor,
                  endColor,
                  particle.progress,
                )!;
                final size =
                    particleSizeTween.transform(particle.progress) * intensity;

                final reverseProgress = 1 - particle.progress;
                switch (type) {
                  case ParticleType.circle:
                    canvas.drawCircle(
                      Offset.zero,
                      size,
                      Paint()
                        ..color = color.withOpacity(
                          reverseProgress,
                        ),
                    );
                    break;
                  case ParticleType.arc:
                    canvas.drawArc(
                      Rect.fromCircle(
                        center: Offset.zero,
                        radius: particleSizeTween.transform(particle.progress),
                      ),
                      flameAngle,
                      1 * pi,
                      false,
                      Paint()
                        ..color = color.withOpacity(reverseProgress)
                        ..strokeWidth = size
                        ..style = PaintingStyle.stroke,
                    );
                    break;
                  case ParticleType.sparkle:
                    canvas.drawCircle(
                      Offset.zero,
                      2,
                      Paint()
                        ..color = orangeColor.withOpacity(
                          reverseProgress,
                        ),
                    );
                    break;
                }
              }),
            );
          },
        ),
      );

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.scale(size.x / 994, size.y / 321);

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
    canvas.restore();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
  }

  @override
  void onRemove() {
    _timer.stop();
    super.onRemove();
  }
}

enum ParticleType { circle, arc, sparkle }
