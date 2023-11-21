import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///have no idea whats going on this page
class Likeaniamtion extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallike;
  const Likeaniamtion({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 150),
    required this.isAnimating,
    this.onEnd,
    this.smallike = false,
  });

  @override
  State<Likeaniamtion> createState() => _LikeaniamtionState();
}

class _LikeaniamtionState extends State<Likeaniamtion>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      //divides it by 2
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  //this widget is called when current widget is replaced by other widget
  @override
  void didUpdateWidget(covariant Likeaniamtion oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  void startAnimation() async {
    if (widget.isAnimating || widget.smallike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(const Duration(milliseconds: 200));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
