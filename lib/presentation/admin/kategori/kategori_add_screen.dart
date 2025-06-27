import 'package:angkut_yuk/presentation/admin/bloc/kategori/kategori_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/data/model/request/admin/kategori_request_model.dart';
import 'package:angkut_yuk/core/color/color.dart';

class KategoriAddScreen extends StatefulWidget {
  const KategoriAddScreen({super.key});

  @override
  State<KategoriAddScreen> createState() => _KategoriAddScreenState();
}

class _KategoriAddScreenState extends State<KategoriAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final namaKategoriController = TextEditingController();

  @override
  void dispose() {
    namaKategoriController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.ungubackgorund,
      appBar: AppBar(
        backgroundColor: Warna.ungu,
        foregroundColor: Colors.white,
        title: Text('Tambah Kategori'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<KategoriBloc, KategoriState>(
        listener: (context, state) {
          if (state is KategoriOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.pop(context, true);
          } else if (state is KategoriFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Kategori Kendaraan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Warna.ungu,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: namaKategoriController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama kategori kendaraan',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Warna.ungu, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama kategori wajib diisi';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 80),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is KategoriLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                final requestModel = KategoriRequestModel(
                                  namaKategori: namaKategoriController.text,
                                );
                                context.read<KategoriBloc>().add(
                                  KategoriCreateRequested(requestModel: requestModel),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Warna.ungu,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: state is KategoriLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Simpan',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
