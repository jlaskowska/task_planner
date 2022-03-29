import 'dart:math';

import 'package:flutter/material.dart';

class TaskCompletionRing extends StatelessWidget {
  final double progress;
  final Color taskCompletedColor;
  final Color taskNotCompletedColor;
  final Widget? child;
  const TaskCompletionRing({
    required this.progress,
    this.taskCompletedColor = Colors.white,
    this.taskNotCompletedColor = Colors.black,
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
    final strokeWidth = size.width / 15;
    final center = Offset(size.height / 2, size.width / 2);
    final radius = (size.width - strokeWidth) / 2;

    final background = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskNotCompletedColor
      ..style = PaintingStyle.stroke;

    final foreground = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskCompletedColor
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, background);

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
