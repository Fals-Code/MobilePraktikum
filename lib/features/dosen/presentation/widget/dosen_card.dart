import 'package:flutter/material.dart';
import '../../data/models/dosen_model.dart';

class DosenCard extends StatelessWidget {
  final DosenModel dosen;

  const DosenCard({super.key, required this.dosen});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue.shade100,
          child: const Icon(Icons.person, color: Colors.blue),
        ),
        title: Text(
          dosen.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("NIDN: ${dosen.nidn}"),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}