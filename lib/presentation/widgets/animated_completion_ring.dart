import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_planner/presentation/widgets/completion_ring.dart';

class AnimatedComletionRing extends StatefulWidget {
  final double size;
  final Color color;
  
  const AnimatedComletionRing({
    this.size = 200,
    this.color = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedComletionRing> createState() => _AnimatedComletionRingState();
}

class _AnimatedComletionRingState extends State<AnimatedComletionRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _animation = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }

  @override
  void dispose() {
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

  void _onTapUp(TapUpDetails details) {
    if (_controller.status != AnimationStatus.completed) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, Widget? child) {
          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: TaskCompletionRing(
              child: Center(
                child: SvgPicture.asset(
                  'assets/svgs/pen.svg',
                  height: widget.size * 0.6,
                  width: widget.size * 0.6,
                  color: widget.color,
                ),
              ),
              progress: _animation.value,
            ),
          );
        },
      ),
    );
  }
}
