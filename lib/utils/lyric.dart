import 'dart:convert';
import 'dart:core';
import '../model/lyric.dart';
import 'dart:io';

RegExp reg = new RegExp(r'(\[\d\d:\d\d.*\])');

class LyricUtilTextModel {
  final int time;
  final String text;
  LyricUtilTextModel(this.time, this.text);
}

class LyricUtilMapValueModel {
  String lrc;
  String tlyric;
  LyricUtilMapValueModel(this.lrc, this.tlyric);
}

class LyricUtil {
  // ignore: missing_return
  static Future<Lyric> loadJson(url) async {
    final httpClient = new HttpClient();
    try {
      final request = await httpClient.getUrl(Uri.parse(url));
      final response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        final json = await response.transform(utf8.decoder).join();
        final data = jsonDecode(json);
        String lrcString = data['lrc']['lyric'];
        String tlyricString = data['tlyric']['lyric'];
        final map = new Map<int, LyricUtilMapValueModel>();
        for (String line in lrcString.split('\n')) {
          if (line == null || line == '') {
            continue;
          }
          LyricUtilTextModel v = getLyric(line);
          if (v.time == -1) {
            continue;
          }
          map[v.time] = new LyricUtilMapValueModel(v.text, '');
        }
        if (tlyricString != null) {
          for (String line in tlyricString.split('\n')) {
            if (line == null || line == '') {
              continue;
            }
            LyricUtilTextModel v = getLyric(line);
            if (v.time == -1) {
              continue;
            }
            if (map[v.time] != null) {
              map[v.time].tlyric = v.text;
            }
          }
        }
        // ignore: deprecated_member_use
        final list = new List<LyricModel>();
        map.forEach((key, value) {
          LyricModel v = new LyricModel(key, value.lrc, value.tlyric);
          list.add(v);
        });
        return new Lyric(list);
      }
    } catch (exception) {
      print(exception);
    }
  }

  static LyricUtilTextModel getLyric(String line) {
    Iterable<Match> matches = reg.allMatches(line);
    if (matches.isEmpty) {
      return new LyricUtilTextModel(-1, '');
    }
    String matchString = matches.elementAt(0).group(0);
    String lyricText = line.replaceAll(matchString, '');
    String timeString = matchString.replaceAll('[', '').replaceAll(']', '');
    String m = timeString.split(':')[0];
    String s = timeString.split(':')[1].split('.')[0];
    String ms = timeString.split(':')[1].split('.')[1];
    int time = int.parse(m) * 60 * 1000 + int.parse(s) * 1000 + int.parse(ms);
    return new LyricUtilTextModel(time, lyricText);
  }
}
