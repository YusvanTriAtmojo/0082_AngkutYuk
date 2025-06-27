import 'package:angkut_yuk/data/model/request/admin/kendaraan_request_model.dart';
import 'package:angkut_yuk/presentation/admin/bloc/kategori/kategori_bloc.dart';
import 'package:angkut_yuk/presentation/admin/bloc/kendaraan/kendaraan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class KendaraanAddScreen extends StatefulWidget {
  const KendaraanAddScreen({super.key});

  @override
  State<KendaraanAddScreen> createState() => _KendaraanAddScreenState();
}

class _KendaraanAddScreenState extends State<KendaraanAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final namaKendaraanController = TextEditingController();
  final platNomorController = TextEditingController();
  final kapasitasMuatanController = TextEditingController();

  int? pilihKategoriId;

  @override
  void initState() {
    super.initState();
    context.read<KategoriBloc>().add(KategoriRequested());
  }

  @override
  void dispose() {
    namaKendaraanController.dispose();
    platNomorController.dispose();
    kapasitasMuatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.ungubackgorund,
      appBar: AppBar(
        backgroundColor: Warna.ungu,
        foregroundColor: Colors.white,
        title: Text('Tambah Kendaraan'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<KendaraanBloc, KendaraanState>(
        listener: (context, state) {
          if (state is KendaraanOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context, true);
          } else if (state is KendaraanFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text('Nama Kendaraan'),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: namaKendaraanController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Nama Kendaraan',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Warna.ungu, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama kendaraan wajib diisi';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 16),
                  Text('Plat Nomor'),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: platNomorController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Plat Nomor',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Warna.ungu, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Plat nomor wajib diisi';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 16),
                  Text('Kapasitas Muatan'),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: kapasitasMuatanController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Kapasitas Muatan (kg)',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Warna.ungu, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kapasitas wajib diisi';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 16),
                  Text('Kategori Kendaraan'),
                  SizedBox(height: 8),
                  BlocBuilder<KategoriBloc, KategoriState>(
                    builder: (context, state) {
                      if (state is KategoriLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is KategoriLoaded) {
                        return DropdownButtonFormField<int>(
                          value: pilihKategoriId,
                          decoration: InputDecoration(
                            hintText: 'Pilih Kategori',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Warna.ungu, width: 2),
                            ),
                          ),
                          items: state.listKategori
                              .map((kategori) => DropdownMenuItem(
                                    value: kategori.id,
                                    child: Text(kategori.namaKategori),
                                  ))
                              .toList(),
                          onChanged: (val) => setState(() => pilihKategoriId = val),
                          validator: (value) {
                            if (value == null) {
                              return  'Kategori wajib dipilih';
                            }
                            return null;
                          },
                        );
                      } else if (state is KategoriFailure) {
                        return Text('Gagal memuat kategori: ${state.error}');
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: state is KendaraanLoading ? null : () {
                      if (_formKey.currentState!.validate()) {
                        final request = KendaraanRequestModel(
                          namaKendaraan: namaKendaraanController.text,
                          platNomor: platNomorController.text,
                          kapasitasMuatan: int.tryParse(kapasitasMuatanController.text) ?? 0,
                          statusKendaraan: 'tersedia',
                          idKategori: pilihKategoriId,
                        );

                        context.read<KendaraanBloc>().add(
                          KendaraanCreateRequested(requestModel: request),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Warna.ungu,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: state is KendaraanLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Simpan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
