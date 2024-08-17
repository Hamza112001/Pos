import 'dart:math';

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  final bool isRoman = true;
  static const roman = [
    'XII',
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
    'X',
    'XI'
  ];

  static const digits = [
    '12'
        '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11'
  ];

  @override
  void paint(Canvas canvas, Size size) {
    const Hour = 5;
    const Minutes = 30;

    final width = size.width;
    final height = size.height;
    final radius = min(width, height) / 2;
    final hoursTickWidth = radius * 0.05;
    final hoursTicklenght = radius * 0.2;
    final hoursNeedleBaseRadius = radius * 0.1;
    final minutesNeedleBaseRadius = radius * 0.1;
    final minutesTickWidth = radius * 0.025;
    final minutesTicklenght = radius * 0.1;
    final hoursNeedleWidth = radius * 0.1;
    final minutesNeedlewidth = radius * 0.09;
    final hoursNeedleGap = radius * 0.4;
    final minutesNeedleGap = radius * 0.3;

    final minutesPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = minutesTickWidth;
    const numberOfTicks = 60;
    const angle = (2 * pi) / numberOfTicks;

    Paint tickPaint;

    final hoursPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = hoursTickWidth;

    final hoursNeedlePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = hoursNeedleWidth
      ..strokeCap = StrokeCap.round;

    final minutesNeedlePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = minutesNeedlewidth
      ..strokeCap = StrokeCap.round;

    final centreOffset = Offset(width / 2, height / 2);
    // Clock Base
    canvas.drawCircle(centreOffset, radius, Paint()..color = Colors.green);
    //needleBase
    canvas.drawCircle(
        centreOffset, hoursNeedleBaseRadius, Paint()..color = Colors.white);
    canvas.save();
    canvas.translate(centreOffset.dx, centreOffset.dy);

    for (var i = 0; i < 60; i++) {
      bool isHour = i % 5 == 0;
      double ticklenght;
      var hour = Hour <= 12 ? Hour : Hour - 12;
      if (i / 5 == hour) {
        canvas.drawLine(Offset(0, -hoursNeedleBaseRadius),
            Offset(0, -radius + minutesNeedleGap), hoursNeedlePaint);
      }
      if (i == Minutes) {
        canvas.drawLine(Offset(0, -minutesNeedleBaseRadius),
            Offset(0, -radius + minutesNeedleGap), minutesNeedlePaint);
      }

      if (isHour) {
        var text = isRoman ? roman[i ~/ 5] : digits[i ~/ 5];
        ticklenght = hoursTicklenght;
        tickPaint = hoursPaint;
        TextPainter textPainter = TextPainter();
        textPainter.textDirection = TextDirection.ltr;
        textPainter.text = TextSpan(text: text);

        textPainter.layout();
        textPainter.paint(canvas, Offset(0, -radius + hoursNeedleGap - 8));
      } else {
        ticklenght = minutesTicklenght;
        tickPaint = minutesPaint;
      }
      canvas.drawLine(
          Offset(0, -radius), Offset(-5, -radius + ticklenght), tickPaint);

      canvas.rotate(angle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ClockPainter oldDelegate) => true;
}
