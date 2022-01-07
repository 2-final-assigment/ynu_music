import 'package:flutter/material.dart';
import 'dart:ui';
import './animate/pointer.dart';
import './animate/disc.dart';
import './model/audio.dart';
import './widget/player.dart';
import 'package:flutter/scheduler.dart';
import './utils/lyric.dart';
import './widget/lyricPannel.dart';

const _LyricPath = 'https://calcbit.com/resource/lyric/';

class Detail extends StatefulWidget {
  final Color color;

  Detail({this.color: Colors.white});

  @override
  State<StatefulWidget> createState() => new DetailState();
}

class DetailState extends State<Detail> with TickerProviderStateMixin {
  Player player = new Player();
  PlayerStatus playerStatus;
  Duration duration;
  Duration position;
  double sliderValue;
  LyricPanel panel;

  @override
  void initState() {
    super.initState();
    playerStatus = player.status;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      resetPanelData();
      player.onDurationChanged(this.onDurationChanged);
      player.onAudioPositionChanged(this.onAudioPositionChanged);
      player.onStatus(this.onPlayerStatus);
      player.onError(this.onError);
      player.onModelChanged(this.onModelChanged);
      player.onCompleted(this.onPlayerCompleted);
    });
  }

  @override
  void deactivate() {
    player.offDurationChanged(this.onDurationChanged);
    player.offAudioPositionChanged(this.onAudioPositionChanged);
    player.offPlaying(this.onPlayerStatus);
    player.offError(this.onError);
    player.offModelChanged(this.onModelChanged);
    player.offCompleted(this.onPlayerCompleted);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    AudioModel model = player.model;
    if (model == null) {
      return Container();
    }
    bool isPlaying = playerStatus == PlayerStatus.process;
    return Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: NetworkImage(model.background),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                Colors.black54,
                BlendMode.overlay,
              ),
            ),
          ),
        ),
        new Container(
            child: new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Opacity(
            opacity: 0.6,
            child: new Container(
              decoration: new BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
          ),
        )),
        new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Container(
              child: Text(
                model.name,
                style: new TextStyle(fontSize: 13.0),
              ),
            ),
          ),
          body: new Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  new GestureDetector(
                      onTap: player.palyHandle,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          new Disc(
                            isPlaying: isPlaying,
                            cover: model.cover,
                          ),
                          !isPlaying
                              ? Padding(
                                  padding: EdgeInsets.only(top: 186.0),
                                  child: Container(
                                    height: 56.0,
                                    width: 56.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        alignment: Alignment.topCenter,
                                        image: AssetImage(
                                            "assets/images/play.png"),
                                      ),
                                    ),
                                  ),
                                )
                              : Text('')
                        ],
                      )),
                  new Pointer(isPlaying: isPlaying),
                ],
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: buildPannel(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  resetPanelData() {
    if (player.duration != null && player.position != null) {
      setState(() {
        this.sliderValue =
            (player.position.inSeconds / player.duration.inSeconds);
      });
    }
    if (player.model != null) {
      LyricUtil.loadJson(_LyricPath + player.model.id.toString() + '.json')
          .then((lyric) {
        setState(() {
          panel = new LyricPanel(lyric);
        });
      });
    }
  }

  onDurationChanged(Duration duration) {
    setState(() {
      this.duration = duration;
      if (position != null) {
        this.sliderValue = (position.inSeconds / duration.inSeconds);
      }
    });
  }

  onAudioPositionChanged(Duration position) {
    setState(() {
      this.position = position;

      if (duration != null) {
        this.sliderValue = (position.inSeconds / duration.inSeconds);
      }
    });
  }

  onPlayerStatus(PlayerStatus status) {
    setState(() {
      playerStatus = status;
    });
  }

  onError(String e) {
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: new Text(e),
      ),
    );
  }

  onModelChanged(AudioModel model) {
    setState(() {
      panel = null;
    });
    resetPanelData();
  }

  onPlayerCompleted() {
    print('onPlayerCompleted =======================');
    player.next();
  }

  String formatDuration(Duration d) {
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }

  Widget buildPannel(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: buildContent(context),
    );
  }

  Widget buildTimer(BuildContext context) {
    final style = new TextStyle(color: widget.color);
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Text(
          position == null ? "--:--" : formatDuration(position),
          style: style,
        ),
        new Text(
          duration == null ? "--:--" : formatDuration(duration),
          style: style,
        ),
      ],
    );
  }

  List<Widget> buildContent(BuildContext context) {
    bool isPlaying = playerStatus == PlayerStatus.process;
    final List<Widget> list = [
      const Divider(color: Colors.transparent),
      const Divider(
        color: Colors.transparent,
        height: 32.0,
      ),
      new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new IconButton(
              onPressed: () {
                player.previous();
              },
              icon: new Icon(
                Icons.skip_previous,
                size: 32.0,
                color: widget.color,
              ),
            ),
            new IconButton(
              onPressed: player.palyHandle,
              padding: const EdgeInsets.all(0.0),
              icon: new Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 48.0,
                color: widget.color,
              ),
            ),
            new IconButton(
              onPressed: () {
                player.next();
              },
              icon: new Icon(
                Icons.skip_next,
                size: 32.0,
                color: widget.color,
              ),
            ),
          ],
        ),
      ),
      new Slider(
        onChanged: (newValue) {
          if (duration != null) {
            int seconds = (duration.inSeconds * newValue).round();
            player.seek(new Duration(seconds: seconds));
          }
        },
        value: sliderValue ?? 0.0,
        activeColor: widget.color,
      ),
      new Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: buildTimer(context),
      ),
    ];

    if (panel != null) {
      list.insert(0, panel);
    }

    return list;
  }
}
