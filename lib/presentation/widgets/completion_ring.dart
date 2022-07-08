import 'dart:math';

import 'package:flutter/material.dart';

class TaskCompletionRing extends StatelessWidget {
  final double progress;
  final Color taskCompletedColor;
  final Color taskNotCompletedColor;
  final Widget? child;
  const TaskCompletionRing({
    required this.progress,
    required this.taskCompletedColor,
    required this.taskNotCompletedColor,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: child,
      painter: CompletionRing(
        progress: progress,
        taskCompletedColor: taskCompletedColor,
        taskNotCompletedColor: taskNotCompletedColor,
      ),
    );
  }
}

class CompletionRing extends CustomPainter {
  final double progress;
  final Color taskNotCompletedColor;
  final Color taskCompletedColor;

  const CompletionRing({
    required this.progress,
    required this.taskCompletedColor,
    required this.taskNotCompletedColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final notCompleted = progress < 1.0;
    final strokeWidth = size.width / 8;
    final center = Offset(size.height / 2, size.width / 2);
    final radius =
        notCompleted ? (size.width - strokeWidth) / 2 : size.width / 2;
    if (notCompleted) {
      final background = Paint()
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = taskNotCompletedColor
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(center, radius, background);
    }

    final foreground = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskCompletedColor
      ..style = notCompleted ? PaintingStyle.stroke : PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foreground,
    );
  }

  @override
  bool shouldRepaint(covariant CompletionRing oldDelegate) =>
      progress != oldDelegate.progress;
}
