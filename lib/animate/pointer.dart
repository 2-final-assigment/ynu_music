import 'package:flutter/material.dart';
import 'dart:math';

// class AnimatePointer extends AnimatedWidget {
//   AnimatePointer({Key key, Animation animation})
//       : super(key: key, listenable: animation);

//   @override
//   Widget build(BuildContext context) {
//     final Animation<double> animation = listenable;
//     return Column(
//       children: <Widget>[
//         Transform(
//           alignment: Alignment.topLeft,
//           transform: Matrix4.rotationZ(animation.value),
//           child: Container(
//             height: 300.0,
//             width: 100.0,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 alignment: Alignment.topCenter,
//                 image: AssetImage("assets/images/pointer.png"),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

class PointerAnimate extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  PointerAnimate({@required this.child, @required this.animation});

  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext ctx, Widget child) {
        return Column(
          children: <Widget>[
            Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.rotationZ(animation.value),
              child: child,
            )
          ],
        );
      },
    );
  }
}

class Pointer extends StatefulWidget {
  final bool isPlaying;

  Pointer({this.isPlaying});

  @override
  State<StatefulWidget> createState() => new PointerState();
}

class PointerState extends State<Pointer> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: -pi / 6, end: 0.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPlaying) {
      controller.forward();
    } else {
      controller.reverse();
    }

    // return AnimatePointer(
    //   animation: animation,
    // );
    return PointerAnimate(
        animation: animation,
        child: Container(
          height: 128.0,
          width: 172.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment(0.5, -1.0),
              image: AssetImage("assets/images/pointer.png"),
            ),
          ),
        ));
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
