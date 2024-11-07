import 'dart:math';

import 'package:flutter/material.dart';

class RadialPercentWidget extends StatelessWidget {
  final Widget child;
  final double percent;
  const RadialPercentWidget(
      {super.key, required this.child, required this.percent});

  @override
  Widget build(BuildContext context) { 
    return Stack(
      fit: StackFit.expand, // растягивает все дочерние виджеты на весь стек
      children: [
        CustomPaint(
          painter: MyPainter(percent: percent / 100),
        ),
        Padding(
          padding: const EdgeInsets.all(7.5),
          child: Center(child: child),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final double percent;

  MyPainter({super.repaint, required this.percent});
  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 5;
    Rect arcRect = calculateArcsRect(size, strokeWidth);

    drawBackground(canvas, size);
    drawFreeArc(strokeWidth, canvas, arcRect);
    drawFilledArc(strokeWidth, canvas, arcRect);
  }

  void drawFilledArc(double strokeWidth, Canvas canvas, Rect arcRect) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    paint.color = percent >= 0.7
        ? const Color.fromARGB(255, 14, 221, 21) // Зеленый
        : percent >= 0.5
            ? const Color.fromARGB(255, 255, 221, 14) // Желтый
            : percent >= 0.25
                ? const Color.fromARGB(255, 255, 165, 0) // Оранжевый
                : percent > 0
                    ? const Color.fromARGB(255, 255, 0, 0) // Красный
                    : const Color.fromARGB(255, 128, 128, 128); // Серый

    canvas.drawArc(
      arcRect,
      -pi / 2,
      pi * 2 * percent,
      false,
      paint,
    );
  }

  void drawFreeArc(double strokeWidth, Canvas canvas, Rect arcRect) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = Colors.grey.shade800;

    canvas.drawArc(
      arcRect,
      pi * 2 * percent - (pi / 2),
      pi * 2 * (1.0 - percent),
      false,
      paint,
    );
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calculateArcsRect(Size size, double strokeWidth) {
    const linesmargin = 5;
    final offset = strokeWidth / 2 + linesmargin;
    return Offset(offset, offset) &
        Size(size.width - offset * 2, size.height - offset * 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}