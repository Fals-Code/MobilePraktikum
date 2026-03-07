class DosenModel {
  final String nama;
  final String nidn;
  final String foto;
  final String bidangKeahlian;
  final String jabatan;

  const DosenModel({
    required this.nama,
    required this.nidn,
    required this.foto,
    this.bidangKeahlian = '',
    this.jabatan = 'Dosen Tetap',
  });

  factory DosenModel.fromJson(Map<String, dynamic> json) {
    return DosenModel(
      nama: json['nama'] ?? '',
      nidn: json['nidn'] ?? '',
      foto: json['foto'] ?? '',
      bidangKeahlian: json['bidangKeahlian'] ?? '',
      jabatan: json['jabatan'] ?? 'Dosen Tetap',
    );
  }
}