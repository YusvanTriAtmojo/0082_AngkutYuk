import 'package:angkut_yuk/presentation/admin/bloc/pesanan/pesanan_bloc.dart';
import 'package:angkut_yuk/presentation/admin/pesanan/konfirmasipesanan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class DaftarpesananScreen extends StatefulWidget {
  const DaftarpesananScreen({super.key});

  @override
  State<DaftarpesananScreen> createState() => _DaftarpesananScreenState();
}

class _DaftarpesananScreenState extends State<DaftarpesananScreen> {
  late PesananAdminBloc _pesananBloc;

  @override
  void initState() {
    super.initState();
    _pesananBloc = context.read<PesananAdminBloc>();
    _pesananBloc.add(AmbilSemuaPesananAdminEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PesananAdminBloc, PesananAdminState>(
        builder: (context, state) {
          if (state is PesananAdminLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PesananAdminFailure) {
            return Center(child: Text("Gagal: ${state.error}"));
          } else if (state is PesananAdminLoaded) {
            final pesananList = state.daftarPesanan;

            if (pesananList.isEmpty) {
              return Center(child: Text('Tidak ada pesanan.'));
            }

            return ListView.builder(
              itemCount: pesananList.length,
              itemBuilder: (context, index) {
                final pesanan = pesananList[index];
               return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Warna.ungubackgorund,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pesanan #${pesanan.id} - ${pesanan.status}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text("Pelanggan: ${pesanan.pelanggan?.namaPelanggan ?? '-'}"),
                            SizedBox(height: 4),
                            Text("Harga: Rp${pesanan.biaya}"),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Warna.orange),
                        onPressed: () async {
                          if (pesanan.status.toLowerCase() == 'pending') {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    KonfirmasipesananScreen(idPesanan: pesanan.id),
                              ),
                            );

                            if (result == true && mounted) {
                              _pesananBloc.add(AmbilSemuaPesananAdminEvent());
                            }
                          } else {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Pesanan tidak bisa dikonfirmasi karena telah dikonfirmasi"),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
