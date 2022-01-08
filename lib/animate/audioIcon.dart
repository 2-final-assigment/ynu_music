import 'package:flutter/material.dart';

class AudioIconAnimate extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  AudioIconAnimate({@required this.child, @required this.animation});

  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext ctx, Widget child) {
        return Column(
          children: <Widget>[
            Container(
              child: RotationTransition(
                turns: animation,
                child: child,
              ),
            )
          ],
        );
      },
    );
  }
}

class AudioIcon extends StatefulWidget {
  final String cover;
  final bool isPlaying;

  AudioIcon({@required this.isPlaying, @required this.cover});

  @override
  State<StatefulWidget> createState() => new AudioIconState();
}

class AudioIconState extends State<AudioIcon>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPlaying) {
      controller.forward();
    } else {
      controller.stop(canceled: false);
    }

    return AudioIconAnimate(
      animation: animation,
      child: Container(
        height: 38.0,
        width: 38.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: NetworkImage(widget.cover),
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
