import 'package:flutter/material.dart';
import 'package:task_planner/presentation/color_extension.dart';
import 'package:task_planner/presentation/widgets/animated_completion_ring.dart';

class TaskTile extends StatefulWidget {
  final String title;
  final String? color;
  final bool isCompleted;
  final VoidCallback onTap;
  final void Function(bool) onChanged;

  const TaskTile({
    required this.title,
    this.color,
    required this.onTap,
    this.isCompleted = false,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  var _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.isCompleted;
  }

  @override
  void didUpdateWidget(covariant TaskTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_isCompleted != widget.isCompleted) {
      _isCompleted = widget.isCompleted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      opacity: _isCompleted ? 0.5 : 1,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: 4,
                height: 36,
                decoration: BoxDecoration(
                  color: widget.color != null
                      ? HexColor.fromHex(widget.color!)
                      : Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Text(
                        widget.title,
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: AnimatedCompletionRing(
                      completed: widget.isCompleted,
                      onAnimationCompleted: (value) async {
                        if (value) {
                          await Future.delayed(
                              const Duration(milliseconds: 400));
                        }
                        widget.onChanged(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
