/*class Alubm {
  final id;
  final name;
  final imag1v1Url;
  Alubm.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        imag1v1Url = json['imag1v1Url'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imag1v1Url': imag1v1Url,
      };
}

class Artists {
  final id;
  final name;
  final imag1v1Url;
  Artists({this.id, this.name, this.imag1v1Url});
  Artists.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        imag1v1Url = json['img1v1Url'];
  Map tojson() => {
        'id': id,
        'name': name,
        'img1v1Url': imag1v1Url,
      };
}

class Songs {
  final id;
  final name;
  final artist;
  final album;
  Songs({this.id, this.name, this.artist, this.album});
  Songs.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        artist = json['artist'],
        album = json['album'];
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
}*/
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

  Result({this.songs, this.hasMore, this.songCount});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.songs != null) {
      data['songs'] = this.songs.map((v) => v.toJson()).toList();
    }
    data['hasMore'] = this.hasMore;
    data['songCount'] = this.songCount;
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
      this.mark});

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
