import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_planner/presentation/widgets/completion_ring.dart';

class AnimatedComletionRing extends StatefulWidget {
  final double size;
  final Color completedIconColor;
  final Color uncompletedIconColor;
  final bool completed;
  final Color taskCompletedBackgroundColor;
  final Color arcColor;

  const AnimatedComletionRing({
    this.size = 200,
    this.completedIconColor = Colors.black87,
    this.completed = false,
    this.arcColor = Colors.black45,
    this.taskCompletedBackgroundColor = Colors.white,
    this.uncompletedIconColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedComletionRing> createState() => _AnimatedComletionRingState();
}

class _AnimatedComletionRingState extends State<AnimatedComletionRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _shouldShowCheckIcon = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _controller.addStatusListener(_checkStatusListner);
    _animation = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }

  void _checkStatusListner(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (mounted) {
        setState(() => _shouldShowCheckIcon = true);
      }
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_checkStatusListner);
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (_controller.status != AnimationStatus.completed) {
      _controller.forward();
    } else {
      _controller.value = 0.0;
    }
  }

  void _onTapUp() {
    if (_controller.status != AnimationStatus.completed) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: (_) => _onTapUp(),
      onTapCancel: _onTapUp,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, Widget? child) {
          final progress = widget.completed ? 1.0 : _animation.value;
          final hasCompleted = progress == 1.0;

          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: TaskCompletionRing(
              taskNotCompletedColor: widget.arcColor,
              taskCompletedColor: widget.taskCompletedBackgroundColor,
              child: Center(
                child: SvgPicture.asset(
                  _shouldShowCheckIcon && hasCompleted
                      ? 'assets/svgs/tick.svg'
                      : 'assets/svgs/pen.svg',
                  height: widget.size * 0.55,
                  width: widget.size * 0.55,
                  color: hasCompleted
                      ? widget.completedIconColor
                      : widget.uncompletedIconColor,
                ),
              ),
              progress: progress,
            ),
          );
        },
      ),
    );
  }
}
