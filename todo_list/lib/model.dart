class Model {
  final String id;
  final String judul;
  final String deskripsi;

  Model({this.id, this.judul, this.deskripsi});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
    );
  }
}
