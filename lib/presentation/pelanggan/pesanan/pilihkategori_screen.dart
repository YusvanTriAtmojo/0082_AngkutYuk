import 'package:angkut_yuk/presentation/pelanggan/bloc/pelanggan/pelanggan_bloc.dart';
import 'package:angkut_yuk/presentation/pelanggan/pesanan/formpesanan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/data/model/response/get_all_kategori_response_model.dart';
import 'package:angkut_yuk/core/color/color.dart';

class KategoriKendaraanScreen extends StatefulWidget {
  const KategoriKendaraanScreen({super.key});

  @override
  State<KategoriKendaraanScreen> createState() => _KategoriKendaraanScreenState();
}

class _KategoriKendaraanScreenState extends State<KategoriKendaraanScreen> {

  @override
  void initState() {
    super.initState();
    context.read<PelangganBloc>().add(AmbilKategoriPelangganEvent());
  }

  void _pilihKategori(Kategori kategori) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormPesananScreen(
          idKategori: kategori.id,
          namaKategori: kategori.namaKategori,
        ),
      ),
    );
  }

  List<Widget> buildKategoriRows(List<Kategori> list) {
    List<Widget> rows = [];
    for (int i = 0; i < list.length; i += 2) {
      rows.add(
        Row(
          children: [
            Expanded(child: buildBox(list[i])),
            SizedBox(width: 16),
            if (i + 1 < list.length)
              Expanded(child: buildBox(list[i + 1]))
            else
              Expanded(child: SizedBox()),
          ],
        ),
      );
      rows.add(SizedBox(height: 16));
    }
    return rows;
  }

  Widget buildBox(Kategori kategori) {
    return ElevatedButton(
      onPressed: () => _pilihKategori(kategori),
      style: ElevatedButton.styleFrom(
        backgroundColor: Warna.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(12),
        elevation: 2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_shipping, color: Warna.ungu, size: 50),
          SizedBox(height: 10),
          Text(
            kategori.namaKategori,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Kategori Kendaraan'),
        backgroundColor: Warna.ungu,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
         color: Warna.ungu
        ),
        child: BlocBuilder<PelangganBloc, PelangganState>(
          builder: (context, state) {
            if (state is PelangganLoading) {
              return Center(child: CircularProgressIndicator(color: Colors.white));
            } else if (state is KategoriPelangganLoaded) {
              final kategoriList = state.kategoriList;
              return SizedBox.expand(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: buildKategoriRows(kategoriList),
                ),
              ),
            );
            } else if (state is PelangganFailure) {
              return Center(
                child: Text(
                  'Gagal memuat kategori: ${state.error}',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Center(
                child: Text(
                  "Tidak ada data kategori tersedia.",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
