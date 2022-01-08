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
