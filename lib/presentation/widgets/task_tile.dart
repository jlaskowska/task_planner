import 'package:flutter/material.dart';
import 'package:task_planner/presentation/widgets/animated_completion_ring.dart';

class TaskTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final bool isCompleted;
  final VoidCallback onTap;
  final void Function(bool) onChanged;

  const TaskTile({
    required this.title,
    this.subtitle,
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

    _isCompleted = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      opacity: _isCompleted ? 0.5 : 1,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    widget.title,
                    softWrap: true,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: AnimatedCompletionRing(
                    onAnimationCompleted: (value) async {
                      if (value) {
                        await Future.delayed(const Duration(milliseconds: 400));
                      }
                      widget.onChanged(value);
                    },
                    uncompletedIconColor: Colors.black,
                    taskCompletedBackgroundColor: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
