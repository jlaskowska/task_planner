import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:task_planner/presentation/widgets/completion_ring.dart';

class AnimatedCompletionRing extends StatefulWidget {
  final double size;
  final Color completedIconColor;
  final Color? uncompletedIconColor;
  final bool completed;
  final Color? taskCompletedBackgroundColor;
  final Color? arcColor;
  final void Function(bool) onAnimationCompleted;

  const AnimatedCompletionRing({
    this.size = 36,
    this.completedIconColor = Colors.white,
    this.completed = false,
    this.arcColor,
    this.taskCompletedBackgroundColor,
    this.uncompletedIconColor,
    required this.onAnimationCompleted,
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedCompletionRing> createState() => _AnimatedCompletionRingState();
}

class _AnimatedCompletionRingState extends State<AnimatedCompletionRing>
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

    if (widget.completed) {
      _shouldShowCheckIcon = true;
    }
    _controller.addStatusListener(_checkStatusListner);
    _animation = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }

  void _checkStatusListner(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onAnimationCompleted(true);
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
    if (!widget.completed && _controller.status != AnimationStatus.completed) {
      _controller.forward();
    } else {
      widget.onAnimationCompleted(false);
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
              taskNotCompletedColor:
                  widget.arcColor ?? Theme.of(context).primaryColorLight,
              taskCompletedColor: widget.taskCompletedBackgroundColor ??
                  Theme.of(context).primaryColor,
              child: Center(
                child: Icon(
                  _shouldShowCheckIcon && hasCompleted
                      ? MdiIcons.check
                      : MdiIcons.close,
                  size: widget.size * 0.5,
                  color: hasCompleted
                      ? widget.completedIconColor
                      : widget.uncompletedIconColor ??
                          Theme.of(context).textTheme.bodyText2?.color,
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
