import 'package:angkut_yuk/presentation/Petugas/home/petugas_home.dart';
import 'package:angkut_yuk/presentation/petugas/riwayat/riwayat_pesanan_screen.dart';
import 'package:flutter/material.dart';
import 'package:angkut_yuk/core/color/color.dart';
import 'package:angkut_yuk/presentation/Petugas/profile/Petugas_profile_screen.dart';

class PetugasScreen extends StatefulWidget {
  const PetugasScreen({super.key});

  @override
  State<PetugasScreen> createState() => _PetugasScreenState();
}

class _PetugasScreenState extends State<PetugasScreen> {
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
        return PetugasHome();
      case 1:
        return RiwayatPesananScreen();
      case 2:
        return PetugasProfileScreen();
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
              label: 'Riwayat',
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
