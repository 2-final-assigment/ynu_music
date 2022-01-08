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
