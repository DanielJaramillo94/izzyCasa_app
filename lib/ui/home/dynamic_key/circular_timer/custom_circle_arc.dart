import 'dart:math' as math;
import 'package:flutter/material.dart';

const double circleRadians = 2 * math.pi;

class CustomCircleArc extends StatelessWidget {
  final Color color;
  final double radians;

  const CustomCircleArc({
    super.key,
    required this.color,
    this.radians = circleRadians,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var diameter = math.min(constraints.maxWidth, constraints.maxHeight);
      return CustomPaint(
        painter: MyPainter(
          color: color,
          radians: radians,
        ),
        size: Size(diameter, diameter),
      );
    });
  }
}

class MyPainter extends CustomPainter {
  final Color color;
  final double radians;

  const MyPainter({
    required this.color,
    required this.radians,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);
    Paint paint = Paint()..color = color;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -circleRadians / 4,
      radians,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
