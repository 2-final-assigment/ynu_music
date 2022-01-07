import 'package:flutter/material.dart';

class Toast {
  static void show(BuildContext context, String message, {int duration}) {
    OverlayEntry entry = OverlayEntry(builder: (context) {
      return Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: new Container(
            child: Text(
              message,
              style: TextStyle(
                backgroundColor: Colors.black,
                color: Colors.white,
                fontSize: 16.0,
                decoration: TextDecoration.none
              ),
            ),
            decoration: new BoxDecoration(
              color: Colors.black,
              borderRadius: new BorderRadius.all(
                const Radius.circular(4.0),
              ),
            ),
            padding: new EdgeInsets.all(8.0),
          ));
    });

    Overlay.of(context).insert(entry);
    Future.delayed(Duration(seconds: duration ?? 2)).then((value) {
      // 移除层可以通过调用OverlayEntry的remove方法。
      entry.remove();
    });
  }
}
