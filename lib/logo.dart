import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Draw the black circle
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width, paint);

    final borderPaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    // Draw the golden border circle
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width, borderPaint);

    // Draw the text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '916',
        style: TextStyle(
          color: Colors.white,
          fontSize: 80,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset((size.width - textPainter.width) / 2,
            (size.height - textPainter.height) / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
