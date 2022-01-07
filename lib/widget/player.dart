import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_flutter/widget/toast.dart';
import '../model/audio.dart';

typedef void CompletedEventCallback();
typedef void ErrorEventCallback(String e);
typedef void StatusEventCallback(PlayerStatus status);
typedef void DurationChangedEventCallback(Duration duration);
typedef void AudioPositionChangedEventCallback(Duration position);
typedef void ModelChangedEventCallback(AudioModel model);

enum PlayerStatus { init, process, pause, finish }
const checkurl =
    "https://netease-cloud-music-api-phi-one.vercel.app/check/music?id=";
const musicurl =
    "https://netease-cloud-music-api-phi-one.vercel.app/song/url?id=";

class Player {
  final completedEvents = new Set<CompletedEventCallback>();
  final errorEvents = new Set<ErrorEventCallback>();
  final statusEvents = new Set<StatusEventCallback>();
  final durationChangedEvents = new Set<DurationChangedEventCallback>();
  final audioPositionChangedEvents =
      new Set<AudioPositionChangedEventCallback>();
  final modelChangedEvents = new Set<ModelChangedEventCallback>();

  final AudioPlayer audioPlayer = new AudioPlayer();
  AudioModel model;
  PlayerStatus status = PlayerStatus.init;
  Duration duration;
  Duration position;

  List<AudioModel> playList;

  /// 音量
  final double volume;
  String url1;

  /// 是否是本地资源
  final bool isLocal;

  static Player _instance;

  static Player get instance => _getInstance();

  Player._internal({this.volume: 1.0, this.isLocal: false}) {
    // 初始化
    audioPlayer
      ..onPlayerCompletion.listen((void s) {
        status = PlayerStatus.finish;
        statusEvents.forEach((fn) => fn(PlayerStatus.finish));
        completedEvents.forEach((fn) => fn());
      })
      ..onPlayerError.listen((String e) {
        errorEvents.forEach((fn) => fn(e));
      })
      ..onDurationChanged.listen((duration) {
        this.duration = duration;
        durationChangedEvents.forEach((fn) => fn(duration));
      })
      ..onAudioPositionChanged.listen((position) {
        this.position = position;
        audioPositionChangedEvents.forEach((fn) => fn(position));
      });
  }

  BuildContext get context => null;

  static Player _getInstance() {
    if (_instance == null) {
      _instance = new Player._internal();
    }
    return _instance;
  }

  getstr(String id) async {
    String url = musicurl + id;
    final httpClient = new HttpClient();
    final request1 = await httpClient.getUrl(Uri.parse(url));
    final response1 = await request1.close();
    if (response1.statusCode == HttpStatus.ok) {
      final json1 = await response1.transform(utf8.decoder).join();
      final res1 = jsonDecode(json1);
      url1 = res1['data'][0]['url'];

      //_model.url ="http://m801.music.126.net/20220107184212/b12535260f34b9c60c71487e8b4034fd/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/12451459971/6fff/3cb5/5aed/9c5b606b01916411d0e8934e5e4805d1.mp3";
      print(url1);
      //_model.url = url1;
    } else {
      print("error1");
    }
    return url1;
  }

  // 工厂模式
  factory Player() => _getInstance();

  play({AudioModel model, List<AudioModel> playList}) async {
    if (playList != null) {
      this.playList = playList;
    }
    if (model != null) {
      this.model = model;
    }
    final httpClient = new HttpClient();

    AudioModel _model = this.model;
    /*String url = musicurl + _model.id;
    final request1 = await httpClient.getUrl(Uri.parse(url));
    final response1 = await request1.close();
    if (response1.statusCode == HttpStatus.ok) {
      final json1 = await response1.transform(utf8.decoder).join();
      final res1 = jsonDecode(json1);
      url1 = res1['data'][0]['url'];

      //_model.url ="http://m801.music.126.net/20220107184212/b12535260f34b9c60c71487e8b4034fd/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/12451459971/6fff/3cb5/5aed/9c5b606b01916411d0e8934e5e4805d1.mp3";
      print(url1);
      //_model.url = url1;
    } else {
      print("error1");
    }
    //model.url = url1;*/
    url1 = await getstr(_model.id);
    String url2 = url1.replaceFirst('http', 'https');
    print(url2);
    //"https://calcbit.com/resource/audio/mp3/%E3%83%95%E3%82%99%E3%83%AB%E3%83%BC%E3%83%8F%E3%82%99%E3%83%BC%E3%83%88%E3%82%99%EF%BC%88%E9%9D%92%E9%B8%9F%EF%BC%89.mp3";
    if (url2 != null) {
      print("y\n");
      int res = await audioPlayer.play(
        url2,
        //"http://m801.music.126.net/20220107184212/b12535260f34b9c60c71487e8b4034fd/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/12451459971/6fff/3cb5/5aed/9c5b606b01916411d0e8934e5e4805d1.mp3",
        isLocal: false,
        volume: volume,
      );
      if (res == 1) {
        print("success");
      } else {
        print("failure");
      }
    } else {
      Toast.show(context, '加载失败2');
    }

    status = PlayerStatus.process;
    statusEvents.forEach((fn) => fn(PlayerStatus.process));
    modelChangedEvents.forEach((fn) => fn(this.model));
  }

  pause() {
    audioPlayer.pause();
    status = PlayerStatus.pause;
    statusEvents.forEach((fn) => fn(PlayerStatus.pause));
  }

  resume() {
    audioPlayer.resume();
    status = PlayerStatus.process;
    statusEvents.forEach((fn) => fn(PlayerStatus.process));
  }

  onCompleted(CompletedEventCallback fn) {
    completedEvents.add(fn);
  }

  onError(ErrorEventCallback fn) {
    errorEvents.add(fn);
  }

  onStatus(StatusEventCallback fn) {
    statusEvents.add(fn);
  }

  onDurationChanged(DurationChangedEventCallback fn) {
    durationChangedEvents.add(fn);
  }

  onAudioPositionChanged(AudioPositionChangedEventCallback fn) {
    audioPositionChangedEvents.add(fn);
  }

  onModelChanged(ModelChangedEventCallback fn) {
    modelChangedEvents.add(fn);
  }

  offCompleted(CompletedEventCallback fn) {
    completedEvents.remove(fn);
  }

  offError(ErrorEventCallback fn) {
    errorEvents.remove(fn);
  }

  offPlaying(StatusEventCallback fn) {
    statusEvents.remove(fn);
  }

  offDurationChanged(DurationChangedEventCallback fn) {
    durationChangedEvents.remove(fn);
  }

  offAudioPositionChanged(AudioPositionChangedEventCallback fn) {
    audioPositionChangedEvents.remove(fn);
  }

  offModelChanged(ModelChangedEventCallback fn) {
    modelChangedEvents.remove(fn);
  }

  seek(Duration d) {
    audioPlayer.seek(d);
  }

  palyHandle() {
    if ((status == PlayerStatus.init || status == PlayerStatus.finish) &&
        model != null) {
      play();
    } else if (status == PlayerStatus.process) {
      pause();
    } else if (status == PlayerStatus.pause) {
      resume();
    }
  }

  previous() {
    if (playList == null) {
      return;
    }
    int index = playList.indexOf(model);
    if (index == -1) {
      return;
    }
    int i = index - 1;
    if (i < 0) {
      i = playList.length - 1;
    }
    play(model: playList[i]);
  }

  next() {
    if (playList == null) {
      return;
    }
    int index = playList.indexOf(model);
    if (index == -1) {
      return;
    }
    int i = index + 1;
    if (i >= playList.length) {
      i = 0;
    }
    play(model: playList[i]);
  }
}
