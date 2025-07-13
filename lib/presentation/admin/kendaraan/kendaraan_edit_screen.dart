import 'package:angkut_yuk/data/model/request/admin/kendaraan_request_model.dart';
import 'package:angkut_yuk/data/model/response/get_all_kendaraan_response_model.dart';
import 'package:angkut_yuk/presentation/admin/bloc/kategori/kategori_bloc.dart';
import 'package:angkut_yuk/presentation/admin/bloc/kendaraan/kendaraan_bloc.dart';
import 'package:angkut_yuk/presentation/admin/home/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class KendaraanEditScreen extends StatefulWidget {
  final Kendaraan kendaraan;

  const KendaraanEditScreen({super.key, required this.kendaraan});

  @override
  State<KendaraanEditScreen> createState() => _KendaraanEditScreenState();
}

class _KendaraanEditScreenState extends State<KendaraanEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController namaController;
  late final TextEditingController platController;
  late final TextEditingController kapasitasController;
  int? selectedKategoriId;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(
      text: widget.kendaraan.namaKendaraan,
    );
    platController = TextEditingController(
      text: widget.kendaraan.platNomor
    );
    kapasitasController = TextEditingController(
      text: widget.kendaraan.kapasitasMuatan.toString(),
    );
    selectedKategoriId = widget.kendaraan.idKategori;
    selectedStatus = widget.kendaraan.statusKendaraan;

    context.read<KategoriBloc>().add(KategoriRequested());
  }

  @override
  void dispose() {
    namaController.dispose();
    platController.dispose();
    kapasitasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.ungubackgorund,
      appBar: AppBar(
        title: Text("Edit Kendaraan"),
        backgroundColor: Warna.ungu,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: BlocConsumer<KendaraanBloc, KendaraanState>(
        listener: (context, state) {
          if (state is KendaraanOperationSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminScreen()),
            );
          } else if (state is KendaraanFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text('Nama Kendaraan'),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: namaController,
                    decoration: InputDecoration(
                      hintText: "Masukkan Nama Kendaraan",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
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
                    controller: platController,
                    decoration: InputDecoration(
                      hintText: "Masukkan Plat Nomor",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
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
                    controller: kapasitasController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Masukkan Kapasitas Muatan (kg)",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
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
                    builder: (context, kategoriState) {
                      if (kategoriState is KategoriLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (kategoriState is KategoriLoaded) {
                        return DropdownButtonFormField<int>(
                          value: selectedKategoriId,
                          decoration: InputDecoration(
                            hintText: "Pilih Kategori",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                color: Warna.ungu,
                                width: 2,
                              ),
                            ),
                          ),
                          items:
                              kategoriState.listKategori
                                  .map(
                                    (kategori) => DropdownMenuItem(
                                      value: kategori.id,
                                      child: Text(kategori.namaKategori),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedKategoriId = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Kategori wajib dipilih';
                            }
                            return null;
                          },
                        );
                      } else {
                        return Text('Gagal memuat kategori');
                      }
                    },
                  ),
                  if ((widget.kendaraan.statusKendaraan.toLowerCase() == 'tersedia' ||
                    widget.kendaraan.statusKendaraan.toLowerCase() == 'rusak'))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      SizedBox(height: 16),
                      Text('Status Kendaraan'),
                      SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedStatus,
                        decoration: InputDecoration(
                          hintText: "Pilih Status",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Warna.ungu, width: 2),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'tersedia', child: Text('Tersedia')),
                          DropdownMenuItem(value: 'rusak', child: Text('Rusak')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Status wajib dipilih';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  ElevatedButton(
                    onPressed:
                        state is KendaraanLoading
                            ? null
                            : () {
                              if (_formKey.currentState!.validate()) {
                                final request = KendaraanRequestModel(
                                  namaKendaraan: namaController.text,
                                  platNomor: platController.text,
                                  kapasitasMuatan: int.parse(
                                    kapasitasController.text,
                                  ),
                                  statusKendaraan:
                                      selectedStatus ?? widget.kendaraan.statusKendaraan,
                                  idKategori: selectedKategoriId,
                                );

                                context.read<KendaraanBloc>().add(
                                  KendaraanUpdateRequested(
                                    id: widget.kendaraan.idKendaraan,
                                    requestModel: request,
                                  ),
                                );
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Warna.ungu,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child:
                        state is KendaraanLoading
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
