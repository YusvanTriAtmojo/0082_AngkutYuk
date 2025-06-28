import 'package:angkut_yuk/data/model/response/get_all_petugas_response_model.dart';
import 'package:angkut_yuk/presentation/admin/bloc/petugas/petugas_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class PetugasDetailScreen extends StatelessWidget {
  final Petugas petugas;
  const PetugasDetailScreen({
    super.key, 
    required this.petugas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Petugas"),
        backgroundColor: Warna.ungu,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Warna.ungubackgorund,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Warna.ungu,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Warna.ungubackgorund,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 20),
                  child: Column(
                    children: [
                      dataRow("Nama", petugas.namaPetugas),
                      SizedBox(height: 10),
                      dataRow("No Telepon", petugas.notlpPetugas),
                      SizedBox(height: 10),
                      dataRow("Alamat", petugas.alamatPetugas),
                      SizedBox(height: 10),
                      dataRow("Status", petugas.statusPetugas),
                    ],
                  ),
                ),
              ),
            ),
           SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return AlertDialog(
                      title: Text("Konfirmasi"),
                      content: Text("Yakin ingin menghapus petugas ini?"),
                      actions: [
                        TextButton(
                          child: Text("Batal"),
                          onPressed: () => Navigator.of(dialogContext).pop(),
                        ),
                        TextButton(
                          child: Text("Hapus", style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            context.read<PetugasBloc>().add(PetugasDeleted(petugas.idPetugas));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: Size(150, 48), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  "Hapus",
                  style: TextStyle(fontSize: 16),
                ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            "$label:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
