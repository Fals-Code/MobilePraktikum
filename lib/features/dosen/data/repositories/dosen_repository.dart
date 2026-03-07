import '../models/dosen_model.dart';

class DosenRepository {
  Future<List<DosenModel>> fetchDosen() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      DosenModel(
        nama: "Dr. Ahmad Fauzi, S.Kom., M.Kom.",
        nidn: "0123456701",
        foto: "https://i.pravatar.cc/150?img=12",
      ),
      DosenModel(
        nama: "Dr. Siti Rahmawati, S.T., M.T.",
        nidn: "0212345602",
        foto: "https://i.pravatar.cc/150?img=5",
      ),
      DosenModel(
        nama: "Prof. Budi Santoso, M.Sc., Ph.D.",
        nidn: "0311223303",
        foto: "https://i.pravatar.cc/150?img=8",
      ),
      DosenModel(
        nama: "Dr. Rina Kurniawati, S.Kom., M.Kom.",
        nidn: "0412349904",
        foto: "https://i.pravatar.cc/150?img=20",
      ),
      DosenModel(
        nama: "Dr. Andi Pratama, S.T., M.T.",
        nidn: "0512377705",
        foto: "https://i.pravatar.cc/150?img=15",
      ),
      DosenModel(
        nama: "Dr. Dewi Lestari, S.Kom., M.Cs.",
        nidn: "0612456706",
        foto: "https://i.pravatar.cc/150?img=32",
      ),
    ];
  }
}