import 'dart:io';
import 'package:angkut_yuk/presentation/petugas/bloc/pesanan/pesanan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:angkut_yuk/core/color/color.dart';

class RiwayatPesananScreen extends StatefulWidget {
  const RiwayatPesananScreen({super.key});

  @override
  State<RiwayatPesananScreen> createState() => _RiwayatPesananScreenState();
}

class _RiwayatPesananScreenState extends State<RiwayatPesananScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PesananPetugasBloc>().add(AmbilPesananSelesaiEvent());
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
        child: BlocBuilder<PesananPetugasBloc, PesananState>(
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
                    "Tidak ada pesanan.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.only(top: 50, left: 30, right: 30),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _data(Icons.person, "Pelanggan", pesanan.pelanggan?.namaPelanggan ?? "-"),
                        SizedBox(height: 8),
                        _data(Icons.directions_car, "Kategori", pesanan.namaKategori),
                        SizedBox(height: 8),
                        _data(Icons.calendar_today, "Tanggal", tanggal),
                        SizedBox(height: 8),
                        _data(Icons.attach_money, "Biaya", "Rp${pesanan.biaya}"),
                        SizedBox(height: 8),
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
        Text("$label: ", 
        style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(value, 
          style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
