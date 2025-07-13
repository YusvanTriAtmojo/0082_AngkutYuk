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
  String selectedStatus = 'Semua';

  @override
  void initState() {
    super.initState();
    context.read<KendaraanBloc>().add(KendaraanRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.ungubackgorund,
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
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, 
                  children: [
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        setState(() => selectedStatus = value);
                        if (value.toLowerCase() == 'semua') {
                          context.read<KendaraanBloc>().add(KendaraanRequested());
                        } else {
                          context.read<KendaraanBloc>().add(FilterKendaraanByStatus(value));
                        }
                      },
                      offset: Offset(0, 40), 
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Warna.unguMuda,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, 
                          children: [
                            Text(
                              selectedStatus,
                              style: TextStyle(fontSize: 12),
                            ),
                            Icon(Icons.arrow_drop_down, size: 18),
                          ],
                        ),
                      ),
                      itemBuilder: (context) => ['Semua', 'tersedia', 'terpakai', 'rusak']
                          .map((status) => PopupMenuItem<String>(
                            value: status,
                            child: Text(status, style: TextStyle(color: Warna.ungu),),
                          ))
                      .toList(),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Expanded(
                  child: BlocBuilder<KendaraanBloc, KendaraanState>(
                    builder: (context, state) {
                      if (state is KendaraanLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is KendaraanFailure) {
                        return Center(child: Text('Gagal memuat data: ${state.error}'));
                      } else if (state is KendaraanLoaded || state is KendaraanFiltered) {
                        final kendaraanList = state is KendaraanLoaded
                            ? state.listKendaraan
                            : (state as KendaraanFiltered).filteredKendaraan;

                        final filtered = selectedStatus == 'Semua'
                            ? kendaraanList
                            : kendaraanList
                                .where((k) =>
                                    k.statusKendaraan.toLowerCase() ==
                                    selectedStatus.toLowerCase())
                                .toList();

                        if (filtered.isEmpty) {
                          return Center(child: Text("Belum ada kendaraan"));
                        }

                        return ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final kendaraan = filtered[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        KendaraanDetailScreen(kendaraan: kendaraan),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Warna.unguMuda,
                                  borderRadius: BorderRadius.circular(12),
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
                                    Icon(Icons.arrow_forward_ios,
                                        size: 16, color: Colors.white),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Center(child: Text("Halaman Kendaraan"));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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

