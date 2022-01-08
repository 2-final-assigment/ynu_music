class Alubm {
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
