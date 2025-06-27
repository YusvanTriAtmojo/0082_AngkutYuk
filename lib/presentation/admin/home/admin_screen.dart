import 'package:angkut_yuk/presentation/admin/kategori/kategori_screen.dart';
import 'package:angkut_yuk/presentation/admin/kendaraan/kendaraan_screen.dart';
import 'package:angkut_yuk/presentation/admin/petugas/petugas_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/presentation/auth/bloc/login/login_bloc.dart';
import 'package:angkut_yuk/presentation/auth/login_screen.dart';
import 'package:angkut_yuk/core/color/color.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String namaAdmin = "Admin";
  int pilihIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(AmbilNamaPenggunaRequested());
  }

  void pilihHalaman(int index) {
    setState(() {
      pilihIndex = index;
    });
  }

  Widget halamanContent() {
    switch (pilihIndex) {
      case 0:
        return Text("Data Home");
      case 1:
        return KendaraanScreen();
      case 2:
        return KategoriScreen();
      case 3:
        return PetugasScreen();
      case 4:
        return Text("Data Keuangan");
      default:
        return Text("Halaman Tidak Ditemukan");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is NamaUserBerhasilDiambil) {
          setState(() {
            namaAdmin = state.nama;
          });
        } else if (state is LogoutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Warna.ungubackgorund,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 180,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: Warna.unguGradasi,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logistics.png', height: 60),
                      SizedBox(width: 15),
                      Text(
                        'AngkutYuk',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(LogoutRequested());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Warna.orange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Halo, $namaAdmin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: halamanContent(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pilihIndex,
          onTap: pilihHalaman,
          selectedItemColor: Warna.ungu,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/home.png', height: 24),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/pickuptruck.png', height: 24),
              label: 'Kendaraan',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/apps.png', height: 24),
              label: 'Kategori',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/driving.png', height: 24),
              label: 'Petugas',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/transfer.png', height: 24),
              label: 'Keuangan',
            ),
          ],
        ),
      ),
    );
  }
}
