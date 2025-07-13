import 'dart:io';

import 'package:angkut_yuk/data/model/response/pelanggan_response_model.dart';
import 'package:angkut_yuk/presentation/auth/bloc/login/login_bloc.dart';
import 'package:angkut_yuk/presentation/auth/login_screen.dart';
import 'package:angkut_yuk/presentation/pelanggan/bloc/pelanggan/pelanggan_bloc.dart';
import 'package:angkut_yuk/presentation/pelanggan/profile/pelanggan_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:angkut_yuk/core/color/color.dart';

class PelangganProfileScreen extends StatefulWidget {
  const PelangganProfileScreen({super.key});

  @override
  State<PelangganProfileScreen> createState() => _PelangganProfileScreenState();
}

class _PelangganProfileScreenState extends State<PelangganProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PelangganBloc>().add(GetPelangganProfileRequested());
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Pilih dari Galeri'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? pickedFile = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 85,
                  );
                  _handlePickedFile(pickedFile);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Ambil dari Kamera'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? pickedFile = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 85,
                  );
                  _handlePickedFile(pickedFile);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handlePickedFile(XFile? pickedFile) {
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      context.read<PelangganBloc>().add(UploadFotoPelangganRequested(imageFile));
    }
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
        body: BlocConsumer<PelangganBloc, PelangganState>(
          listener: (context, state) {
            if (state is PelangganFotoUploadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              context.read<PelangganBloc>().add(GetPelangganProfileRequested());
            } else if (state is PelangganFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Upload gagal: ${state.error}")),
              );
            }
          },
          builder: (context, state) {
            if (state is PelangganLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PelangganFailure) {
              return Center(child: Text("Gagal memuat data: ${state.error}"));
            } else if (state is PelangganLoaded) {
              final DataPelanggan pelanggan = state.pelanggan;
              final imageUrl = pelanggan.fotoProfile;
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  SizedBox(height: 16),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipOval(
                          child: imageUrl != null
                              ? Image.network(
                                  imageUrl,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/profile.png',
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/profile.png',
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          right: 4,
                          bottom: 4,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.deepPurple,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text('Logout'),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Data Pelanggan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4B0082),
                    ),
                  ),
                  SizedBox(height: 10),
                  dataProfile(Icons.person, "Nama", pelanggan.namaPelanggan),
                  dataProfile(Icons.email, "Email", pelanggan.email),
                  dataProfile(Icons.phone, "Nomor Telepon", pelanggan.notlpPelanggan),
                  dataProfile(Icons.home, "Alamat", pelanggan.alamatPelanggan),
                ],
              );
            } else {
              return Center(child: Text("Belum ada data pelanggan"));
            }
          },
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 40),
          child: FloatingActionButton(
            onPressed: () async {
              final state = context.read<PelangganBloc>().state;
              if (state is PelangganLoaded) {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PelangganEditScreen(pelanggan: state.pelanggan),
                  ),
                );
                if (result == true) {
                  context.read<PelangganBloc>().add(GetPelangganProfileRequested());
                }
              }
            },
            backgroundColor: Warna.orange,
            child: Icon(Icons.edit, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget dataProfile(IconData icon, String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
                    color: Warna.unguMuda,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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
