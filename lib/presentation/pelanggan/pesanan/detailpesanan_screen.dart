import 'package:angkut_yuk/presentation/pelanggan/pesanan/datapesanan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/data/model/request/pelanggan/pesanan_request_model.dart';
import 'package:angkut_yuk/presentation/pelanggan/bloc/pesanan/pesanan_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class DetailPesananScreen extends StatelessWidget {
  final PesananRequestModel pesanan;

  const DetailPesananScreen({
    super.key,
    required this.pesanan,
  });

  void _kirimPesanan(BuildContext context) {
    context.read<PesananBloc>().add(PesananCreateRequested(pesanan));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: Warna.unguGradasi,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: BlocListener<PesananBloc, PesananState>(
            listener: (context, state) {
              if (state is PesananSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.pesan)),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataPesananScreen(), 
                  ),
                );
              } else if (state is PesananFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Gagal mengirim pesanan: ${state.error}")),
                );
              }
            },
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      color: Colors.white,
                      elevation: 8,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Detail Pesanan",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            detailPesanan("Kategori Kendaraan", pesanan.namaKategori),
                            detailPesanan("Alamat Jemput", pesanan.alamatJemput),
                            detailPesanan("Alamat Tujuan", pesanan.alamatTujuan),
                            detailPesanan("Tanggal Jemput", pesanan.tanggalJemput),
                            detailPesanan("Jarak", "${pesanan.jarakKm?.toStringAsFixed(2)} km"),
                            detailPesanan("Biaya", "Rp${pesanan.biaya?.toStringAsFixed(0)}"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text('Kembali'),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _kirimPesanan(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text('Kirim'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget detailPesanan(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value ?? '-', style: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
