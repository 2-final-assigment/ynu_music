import 'dart:convert';
import 'dart:io';

class AudioModel {
  final String id;
  final String name;
  final String author;
  final String url;
  final String cover;
  final String background;
  final httpClient = new HttpClient();

  //User user;
  //String str = 'https://music.163.com/song/media/outer/song/url?id=';
  AudioModel(
      this.id, this.name, this.author, this.url, this.cover, this.background);

  AudioModel.fromJson(Map<String, dynamic> json)
      :
        //result = json['result'] != null ? new Result.fromJson(json['result']).toJson()['result'] : null,
        //song = json['song'] != null ? new Songs.fromJson(json['song']) : null,
        id = json['id'],
        name = json['name'],
        author = json['author'],
        //Artists.fromJson(json['artists'])
        //.toJson()['name'],
        url = json['url'],
        // 'http://m10.music.126.net/20220107155228/8d9097e033fa86bbe341aef6e6124d27/ymusic/obj/w5zDlMODwrDDiGjCn8Ky/2839281955/47e7/b3c1/23e4/0bb76a303e1ba1a7f1dfe32e573224a6.mp3',
        //"https://music.163.com/song/media/outer/url?id=" +
        //json['id'].toString() +
        //".mp3",
        cover = json['cover'],
        //"https://p1.music.126.net/MxMt67BMwy505AHiTvnMqg==/2384840720672469.jpg?imageView&thumbnail=360y360&quality=75&tostatic=0",
        // Album.fromJson(json['album'])
        //  .toJson()['picUrl'],
        background = json['background'];
  // "https://p1.music.126.net/MxMt67BMwy505AHiTvnMqg==/2384840720672469.jpg?imageView&thumbnail=360y360&quality=75&tostatic=0";
  //Album.fromJson(json['album'])
  //  .toJson()['blurPicUrl'];
  // ignore: empty_constructor_bodies
  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["name"] = this.name;
    map["author"] = this.author;
    map["url"] = this.url;
    map["cover"] = this.cover;
    map["background"] = this.background;
    return map;
  }
}
