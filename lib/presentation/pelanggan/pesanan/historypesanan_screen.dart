import 'package:angkut_yuk/presentation/pelanggan/bloc/pesanan/pesanan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';
import 'package:intl/intl.dart';

class HistorypesananScreen extends StatefulWidget {
  const HistorypesananScreen({super.key});

  @override
  State<HistorypesananScreen> createState() => _HistorypesananScreenState();
}

class _HistorypesananScreenState extends State<HistorypesananScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PesananBloc>().add(AmbilPesananSelesaiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History Pesanan"),
        backgroundColor: Warna.ungu,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: Warna.unguGradasi,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocBuilder<PesananBloc, PesananState>(
          builder: (context, state) {
            if (state is PesananLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (state is PesananLoaded) {
              final pesananList = state.daftarPesanan;
              if (pesananList.isEmpty) {
                return Center(
                  child: Text(
                    "Tidak ada History.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: pesananList.length,
                itemBuilder: (context, index) {
                  final pesanan = pesananList[index];
                  final tanggal = DateFormat('dd MMM yyyy • HH:mm').format(pesanan.tanggalJemput!);
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _data(Icons.directions_car, "Kategori", pesanan.namaKategori),
                              SizedBox(height: 8),
                              _data(Icons.calendar_today, "Tanggal", tanggal),
                              SizedBox(height: 8),
                              _data(Icons.attach_money, "Biaya", "Rp${pesanan.biaya.toString()}"),
                            ],
                          ),
                        ),
                        if (pesanan.fotoBuktiSelesai != null && pesanan.fotoBuktiSelesai!.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              pesanan.fotoBuktiSelesai!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Text("Gagal memuat gambar", textAlign: TextAlign.center);
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is PesananFailure) {
              return Center(
                child: Text(
                  "Gagal memuat data:\n${state.error}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  Widget _data(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.deepPurple),
        SizedBox(width: 8),
        Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
