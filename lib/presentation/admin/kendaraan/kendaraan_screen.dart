import 'package:angkut_yuk/data/model/response/get_all_kendaraan_response_model.dart';
import 'package:angkut_yuk/presentation/admin/bloc/kendaraan/kendaraan_bloc.dart';
import 'package:angkut_yuk/presentation/admin/kendaraan/kendaraan_detail_screen.dart';
import 'package:angkut_yuk/presentation/admin/kendaraan/kendaraan_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class KendaraanScreen extends StatefulWidget {
  const KendaraanScreen({super.key});

  @override
  State<KendaraanScreen> createState() => _KendaraanScreenState();
}

class _KendaraanScreenState extends State<KendaraanScreen> {
  @override
  void initState() {
    super.initState();
    context.read<KendaraanBloc>().add(KendaraanRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.ungubackgorund,
      body: BlocBuilder<KendaraanBloc, KendaraanState>(
        builder: (context, state) {
          if (state is KendaraanLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is KendaraanFailure) {
            return Center(child: Text('Gagal memuat data: ${state.error}'));
          } else if (state is KendaraanLoaded) {
            final List<Kendaraan> kendaraanList = state.listKendaraan;
            if (kendaraanList.isEmpty) {
              return Center(child: Text("Belum ada kendaraan"));
            }
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: kendaraanList.length,
              itemBuilder: (context, index) {
                final kendaraan = kendaraanList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => KendaraanDetailScreen(kendaraan: kendaraan),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Warna.unguMuda,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Warna.ungu,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.local_shipping, color: Colors.white),
                        SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                kendaraan.namaKendaraan,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                kendaraan.platNomor,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Halaman Kendaraan"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KendaraanAddScreen()),
          ).then((result) {
            if (result == true) {
              context.read<KendaraanBloc>().add(KendaraanRequested());
            }
          });
        },
        backgroundColor: Warna.orange,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
