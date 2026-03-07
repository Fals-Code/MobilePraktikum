class DosenModel {
  final String nama;
  final String nidn;
  final String foto;

  DosenModel({
    required this.nama,
    required this.nidn,
    required this.foto,
  });

  factory DosenModel.fromJson(Map<String, dynamic> json) {
    return DosenModel(
      nama: json['nama'] ?? '',
      nidn: json['nidn'] ?? '',
      foto: json['foto'] ?? '',
    );
  }
}