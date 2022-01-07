import 'package:flutter/material.dart';
import '../model/lyric.dart';
import './player.dart';
import 'package:flutter/scheduler.dart';

typedef void PositionChangeHandler(int millisecond);

class LyricPanel extends StatefulWidget {
  final Lyric lyric;

  LyricPanel(this.lyric);

  @override
  State<StatefulWidget> createState() {
    return new LyricState();
  }
}

class LyricState extends State<LyricPanel> {
  int index = 0;
  LyricModel currentModel;
  Player player = new Player();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      resetIndex();
      player.onAudioPositionChanged(this.onAudioPositionChanged);
    });
  }

  @override
  void deactivate() {
    player.offAudioPositionChanged(this.onAudioPositionChanged);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Column(
            children: <Widget>[
              Text(
                currentModel != null ? currentModel.lrc : "",
                style: new TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                currentModel != null ? currentModel.tlyric : "",
                style: new TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildLyricItems(Lyric lyric) {
    // ignore: deprecated_member_use
    List<Widget> items = new List();
    for (LyricModel model in lyric.list) {
      if (model != null && model.lrc != null) {
        items.add(new Center(
          child: new Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              model.lrc,
              style: new TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ));
      }
    }
    return items;
  }

  resetIndex() {
    if (player.position != null) {
      int ms = player.position.inMilliseconds;
      for (int i = 0; i < widget.lyric.list.length; i++) {
        LyricModel model = widget.lyric.list[i];
        if (ms >= model.millisecond) {
          index = i;
        } else {
          break;
        }
      }
      setState(() {
        currentModel = widget.lyric.list[index];
      });
    }
  }

  onAudioPositionChanged(Duration position) {
    int ms = position.inMilliseconds;
    // ms 在前一个之前或者后一个之后，就需要重新定位index了
    if ((index > 0 && ms <= widget.lyric.list[index - 1].millisecond) ||
        (index < widget.lyric.list.length - 1 &&
            ms >= widget.lyric.list[index + 1].millisecond)) {
      resetIndex();
      return;
    }

    LyricModel model = widget.lyric.list[index];
    if (ms > model.millisecond) {
      index++;
      setState(() {
        currentModel = model;
      });
    }
  }
}
