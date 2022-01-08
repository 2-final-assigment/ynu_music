import 'package:flutter/material.dart';

class DiscAnimate extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  DiscAnimate({@required this.child, @required this.animation});

  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext ctx, Widget child) {
        return Column(
          children: <Widget>[
            Container(
              margin: new EdgeInsets.symmetric(vertical: 10.0),
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

class Disc extends StatefulWidget {
  final String cover;
  final bool isPlaying;

  Disc({@required this.isPlaying, @required this.cover});

  @override
  State<StatefulWidget> createState() => new DiscState();
}

class DiscState extends State<Disc> with SingleTickerProviderStateMixin {
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

    return Padding(
      padding: const EdgeInsets.only(top: 68.0),
      child: DiscAnimate(
        animation: animation,
        child: Container(
          height: 280.0,
          width: 280.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage("assets/images/disc.png"),
            ),
          ),
          child: Center(
            child: Container(
              height: 180.0,
              width: 180.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: NetworkImage(widget.cover),
                ),
              ),
            ),
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
