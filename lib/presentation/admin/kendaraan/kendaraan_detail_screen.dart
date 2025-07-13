import 'package:angkut_yuk/data/model/response/get_all_kendaraan_response_model.dart';
import 'package:angkut_yuk/presentation/admin/bloc/kendaraan/kendaraan_bloc.dart';
import 'package:angkut_yuk/presentation/admin/kendaraan/kendaraan_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class KendaraanDetailScreen extends StatelessWidget {
  final Kendaraan kendaraan;

  const KendaraanDetailScreen({
    super.key,
    required this.kendaraan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Kendaraan"),
        backgroundColor: Warna.ungu,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/mobil.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(color: Warna.ungubackgorund.withAlpha(191)),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Warna.ungu,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Warna.ungubackgorund,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 60, right: 30),
                      child: Column(
                        children: [
                          dataRow("Nama", kendaraan.namaKendaraan),
                          SizedBox(height: 10),
                          dataRow("Plat Nomor", kendaraan.platNomor),
                          SizedBox(height: 10),
                          dataRow("Muatan", "${kendaraan.kapasitasMuatan} kg"),
                          SizedBox(height: 10),
                          dataRow("Status", kendaraan.statusKendaraan),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KendaraanEditScreen(kendaraan: kendaraan),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.white,
                        minimumSize: Size(150, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: 
                      Text(
                        "Edit",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: Text("Konfirmasi"),
                              content: Text("Yakin ingin menghapus kendaraan ini?"),
                              actions: [
                                TextButton(
                                  child: 
                                  Text("Batal"),
                                  onPressed: () => Navigator.of(dialogContext).pop(),
                                ),
                                TextButton(
                                  child: 
                                  Text("Hapus", style: TextStyle(color: Colors.red)),
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                    context.read<KendaraanBloc>().add(
                                          KendaraanDeleted(kendaraan.idKendaraan),
                                        );
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
                      child: 
                      Text(
                        "Hapus",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
