class MahasiswaModel {
  final int    postId;
  final int    id;
  final String name;
  final String email;
  final String body;

  const MahasiswaModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) =>
      MahasiswaModel(
        postId: json['postId'] ?? 0,
        id:     json['id']     ?? 0,
        name:   json['name']   ?? '',
        email:  json['email']  ?? '',
        body:   json['body']   ?? '',
      );

  Map<String, dynamic> toJson() => {
    'postId': postId,
    'id':     id,
    'name':   name,
    'email':  email,
    'body':   body,
  };
}

// Model untuk Mahasiswa Aktif — API /posts
class MahasiswaAktifModel {
  final int    userId;
  final int    id;
  final String title;
  final String body;

  const MahasiswaAktifModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory MahasiswaAktifModel.fromJson(Map<String, dynamic> json) =>
      MahasiswaAktifModel(
        userId: json['userId'] ?? 0,
        id:     json['id']     ?? 0,
        title:  json['title']  ?? '',
        body:   json['body']   ?? '',
      );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id':     id,
    'title':  title,
    'body':   body,
  };
}