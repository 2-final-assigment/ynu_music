/*class Alubm {
  final String id;
  final String name;
  final String imag1v1Url;
  Alubm.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'],
        imag1v1Url = json['imag1v1Url'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imag1v1Url': imag1v1Url,
      };
}

class Artists {
  final String id;
  final String name;
  final String imag1v1Url;
  Artists({this.id, this.name, this.imag1v1Url});
  Artists.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'],
        imag1v1Url = json['img1v1Url'];
  Map tojson() => {
        'id': id,
        'name': name,
        'img1v1Url': imag1v1Url,
      };
}

class Songs {
  final String id;
  final String name;
  final artist;
  final album;
  Songs({this.id, this.name, this.artist, this.album});
  Songs.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'],
        artist = Artists.fromJson(json['artist']),
        album = Alubm.fromJson(json['album']);
  Map toJson() => {
        'id': id,
        'name': name,
        'artist': artist,
        'album': album,
      };
}

class User {
  Songs songs;
  User(this.songs);
  User.fromJson(Map<String, dynamic> json)
      : songs = Songs.fromJson(json['songs']);
  Map<String, dynamic> toJson() => {
        'songs': songs,
      };
}
*/
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class User {
  Result result;
  int code;

  User({this.result, this.code});

  User.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Result {
  List<Songs> songs;
  bool hasMore;
  int songCount;
  int code;

  Result({this.songs, this.hasMore, this.songCount, this.code});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['songs'] != null) {
      // ignore: deprecated_member_use
      songs = new List<Songs>();
      json['songs'].forEach((v) {
        songs.add(new Songs.fromJson(v));
      });
    }
    hasMore = json['hasMore'];
    songCount = json['songCount'];
    code = 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.songs != null) {
      data['songs'] = this.songs.map((v) => v.toJson()).toList();
    }
    data['hasMore'] = this.hasMore;
    data['songCount'] = this.songCount;
    data['code'] = this.code;
    return data;
  }
}

class Songs {
  int id;
  String name;
  List<Artists> artists;
  Album album;
  int duration;
  int copyrightId;
  int status;
  List<String> alias;
  int rtype;
  int ftype;
  List<String> transNames;
  int mvid;
  int fee;
  Null rUrl;
  int mark;
  int code;

  Songs(
      {this.id,
      this.name,
      this.artists,
      this.album,
      this.duration,
      this.copyrightId,
      this.status,
      this.alias,
      this.rtype,
      this.ftype,
      this.transNames,
      this.mvid,
      this.fee,
      this.rUrl,
      this.mark,
      this.code});

  Songs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['artists'] != null) {
      // ignore: deprecated_member_use
      artists = new List<Artists>();
      json['artists'].forEach((v) {
        artists.add(new Artists.fromJson(v));
      });
    }
    album = json['album'] != null ? new Album.fromJson(json['album']) : null;
    duration = json['duration'];
    copyrightId = json['copyrightId'];
    status = json['status'];
    alias = json['alias'].cast<String>();
    rtype = json['rtype'];
    ftype = json['ftype'];
    transNames = json['transNames'].cast<String>();
    mvid = json['mvid'];
    fee = json['fee'];
    rUrl = json['rUrl'];
    mark = json['mark'];
    code = 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    if (this.album != null) {
      data['album'] = this.album.toJson();
    }
    data['duration'] = this.duration;
    data['copyrightId'] = this.copyrightId;
    data['status'] = this.status;
    data['alias'] = this.alias;
    data['rtype'] = this.rtype;
    data['ftype'] = this.ftype;
    data['transNames'] = this.transNames;
    data['mvid'] = this.mvid;
    data['fee'] = this.fee;
    data['rUrl'] = this.rUrl;
    data['mark'] = this.mark;
    data['code'] = this.code;
    return data;
  }
}

class Artists {
  int id;
  String name;
  Null picUrl;
  List<Null> alias;
  int albumSize;
  int picId;
  String img1v1Url;
  int img1v1;
  Null trans;

  Artists(
      {this.id,
      this.name,
      this.picUrl,
      this.alias,
      this.albumSize,
      this.picId,
      this.img1v1Url,
      this.img1v1,
      this.trans});

  Artists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picUrl = json['picUrl'];
    if (json['alias'] != null) {
      // ignore: deprecated_member_use
      alias = new List<Null>();
      json['alias'].forEach((v) {
        //alias.add(new Null.fromJson(v));
      });
    }
    albumSize = json['albumSize'];
    picId = json['picId'];
    img1v1Url = json['img1v1Url'];
    img1v1 = json['img1v1'];
    trans = json['trans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picUrl'] = this.picUrl;
    if (this.alias != null) {
      //data['alias'] = this.alias.map((v) => v.toJson()).toList();
    }
    data['albumSize'] = this.albumSize;
    data['picId'] = this.picId;
    data['img1v1Url'] = this.img1v1Url;
    data['img1v1'] = this.img1v1;
    data['trans'] = this.trans;
    return data;
  }
}

class Album {
  int id;
  String name;
  Artists artist;
  int publishTime;
  int size;
  int copyrightId;
  int status;
  int picId;
  int mark;
  List<String> alia;

  Album(
      {this.id,
      this.name,
      this.artist,
      this.publishTime,
      this.size,
      this.copyrightId,
      this.status,
      this.picId,
      this.mark,
      this.alia});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    artist =
        json['artist'] != null ? new Artists.fromJson(json['artist']) : null;
    publishTime = json['publishTime'];
    size = json['size'];
    copyrightId = json['copyrightId'];
    status = json['status'];
    picId = json['picId'];
    mark = json['mark'];
    alia = json['alia'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
    data['publishTime'] = this.publishTime;
    data['size'] = this.size;
    data['copyrightId'] = this.copyrightId;
    data['status'] = this.status;
    data['picId'] = this.picId;
    data['mark'] = this.mark;
    data['alia'] = this.alia;
    return data;
  }
}

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
        /*id = json['id'],
        name = json['name'],
        url = json['url'],
        author = json['author'],
        cover = json['cover'],
        background = json['background'];*/
        //result = json['result'] != null ? new Result.fromJson(json['result']).toJson()['result'] : null,
        //song = json['song'] != null ? new Songs.fromJson(json['song']) : null,
        id = json['id'].toString(),
        name = json['name'],
        author = json['artists'][0]['name'],
        //Artists.fromJson(json['artists'])
        //.toJson()['name'],

        //final httpClient = new HttpClient();

        url =
            //'http://m10.music.126.net/20220107155228/8d9097e033fa86bbe341aef6e6124d27/ymusic/obj/w5zDlMODwrDDiGjCn8Ky/2839281955/47e7/b3c1/23e4/0bb76a303e1ba1a7f1dfe32e573224a6.mp3',
            "https://music.163.com/song/media/outer/url?id=" +
                json['id'].toString() +
                ".mp3",

        //"https://p1.music.126.net/MxMt67BMwy505AHiTvnMqg==/2384840720672469.jpg?imageView&thumbnail=360y360&quality=75&tostatic=0",
        // Album.fromJson(json['album'])
        //  .toJson()['picUrl'],
        cover = json['artists'][0]['img1v1Url'],
        background = json['album']['artist']['img1v1Url'];
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
