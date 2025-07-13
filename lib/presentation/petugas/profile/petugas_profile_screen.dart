import 'package:angkut_yuk/data/model/response/petugas_response_model.dart';
import 'package:angkut_yuk/presentation/auth/bloc/login/login_bloc.dart';
import 'package:angkut_yuk/presentation/auth/login_screen.dart';
import 'package:angkut_yuk/presentation/petugas/bloc/petugas/petugas_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class PetugasProfileScreen extends StatefulWidget {
  const PetugasProfileScreen({super.key});

  @override
  State<PetugasProfileScreen> createState() => _PetugasProfileScreenState();
}

class _PetugasProfileScreenState extends State<PetugasProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PetugasprofilBloc>().add(GetPetugasProfileRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Warna.ungubackgorund,
        body: BlocBuilder<PetugasprofilBloc, PetugasState>(
          builder: (context, state) {
            if (state is PetugasLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PetugasFailure) {
              return Center(child: Text("Gagal memuat data: ${state.error}"));
            } else if (state is PetugasLoaded) {
              final DataPetugas petugas = state.petugas;

              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  SizedBox(height: 16),
                  Center(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile.png',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text('Logout'),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Data Petugas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4B0082),
                    ),
                  ),
                  SizedBox(height: 10),
                  dataProfile(Icons.person, "Nama", petugas.namaPetugas),
                  dataProfile(Icons.email, "Email", petugas.email),
                  dataProfile(Icons.phone, "Nomor Telepon", petugas.notlpPetugas),
                  dataProfile(Icons.home, "Alamat", petugas.alamatPetugas),
                ],
              );
            } else {
              return Center(child: Text("Belum ada data Petugas"));
            }
          },
        ),
      ),
    );
  }

  Widget dataProfile(IconData icon, String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Warna.ungu,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Warna.orange),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Warna.ungu,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
