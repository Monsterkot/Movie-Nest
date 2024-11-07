import 'package:flutter/material.dart';
import 'package:movie_nest_app/theme/app_colors.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.mainColor;
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint);

    /// Рисуем большой круг
    final bigCirclePaint = Paint()
      ..color = AppColors.bigCircleColor
      ..style = PaintingStyle.fill;

    double bigCircleRadius = 150; // Радиус большого круга
    Offset bigCircleCenter = Offset(
        size.width, size.height); // Центр большого круга в правом нижнем углу

    // Рисуем большой круг, часть которого выходит за границы экрана
    canvas.drawCircle(bigCircleCenter, bigCircleRadius, bigCirclePaint);

    // Рисуем меньший круг
    final smallCirclePaint = Paint()
      ..color = AppColors.smallCircleColor
      ..style = PaintingStyle.fill;

    double smallCircleRadius = 80; // Радиус меньшего круга
    Offset smallCircleCenter =
        Offset(size.width - 80, size.height - 200); // Центр меньшего круга

    // Рисуем меньший круг
    canvas.drawCircle(smallCircleCenter, smallCircleRadius, smallCirclePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // Не перерисовывать, если нет изменений
  }
}
