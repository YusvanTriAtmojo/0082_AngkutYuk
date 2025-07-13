import 'package:angkut_yuk/presentation/pelanggan/home/pelanggan_home.dart';
import 'package:flutter/material.dart';
import 'package:angkut_yuk/core/color/color.dart';
import 'package:angkut_yuk/presentation/pelanggan/pesanan/datapesanan_screen.dart';
import 'package:angkut_yuk/presentation/pelanggan/profile/pelanggan_profile_screen.dart';

class PelangganScreen extends StatefulWidget {
  const PelangganScreen({super.key});

  @override
  State<PelangganScreen> createState() => _PelangganScreenState();
}

class _PelangganScreenState extends State<PelangganScreen> {
  String namaPelanggan = "Pelanggan";
  int pilihIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void pilihHalaman(int index) {
    setState(() {
      pilihIndex = index;
    });
  }

  Widget halamanContent() {
    switch (pilihIndex) {
      case 0:
        return PelangganHome();
      case 1:
        return DataPesananScreen();
      case 2:
        return PelangganProfileScreen();
      default:
        return Center(child: Text("Halaman tidak ditemukan"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Warna.ungubackgorund,
        body: halamanContent(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pilihIndex,
          onTap: pilihHalaman,
          selectedItemColor: Warna.ungu,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Pesanan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
    );
  }
}
