import 'package:flutter/material.dart';
import 'package:izzy_casa_app/ui/home/dynamic_key/circular_timer/custom_circle_arc.dart';

class CircularTimer extends StatefulWidget {
  const CircularTimer({
    super.key,
  });

  @override
  State<CircularTimer> createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomCircleArc(
          color: Colors.orange.shade200,
          radians: circleRadians,
        ),
        AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return CustomCircleArc(
                color: Colors.grey.shade400,
                radians: circleRadians * _animation.value,
              );
            }),
      ],
    );
  }
}
