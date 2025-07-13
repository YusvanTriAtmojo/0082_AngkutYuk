import 'package:angkut_yuk/presentation/admin/home/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';
import 'package:angkut_yuk/data/model/response/get_all_petugas_response_model.dart';
import 'package:angkut_yuk/data/model/request/admin/petugas_request_model.dart';
import 'package:angkut_yuk/presentation/admin/bloc/petugas/petugas_bloc.dart';

class PetugasEditScreen extends StatefulWidget {
  final Petugas petugas;

  const PetugasEditScreen({super.key, required this.petugas});

  @override
  State<PetugasEditScreen> createState() => _PetugasEditScreenState();
}

class _PetugasEditScreenState extends State<PetugasEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController namaController;
  late final TextEditingController teleponController;
  late final TextEditingController alamatController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.petugas.namaPetugas);
    teleponController = TextEditingController(text: widget.petugas.notlpPetugas);
    alamatController = TextEditingController(text: widget.petugas.alamatPetugas);
  }

  @override
  void dispose() {
    namaController.dispose();
    teleponController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.ungubackgorund,
      appBar: AppBar(
        title: Text("Edit Petugas"),
        backgroundColor: Warna.ungu,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: BlocConsumer<PetugasBloc, PetugasState>(
        listener: (context, state) {
          if (state is PetugasOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminScreen()),
            );
          } else if (state is PetugasFailure) {
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
                  Text('Nama Petugas'),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: namaController,
                    decoration: InputDecoration(
                      hintText: "Masukkan Nama Petugas",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                        return 'Nama petugas wajib diisi';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 16),
                  Text('Nomor Telepon'),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: teleponController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Masukkan Nomor Telepon",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                        return 'Nomor telepon wajib diisi';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 16),
                  Text('Alamat'),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: alamatController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Masukkan Alamat",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Warna.ungu, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return  'Alamat wajib diisi';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: state is PetugasLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              final request = PetugasRequestModel(
                                namaPetugas: namaController.text,
                                notlpPetugas: teleponController.text,
                                alamatPetugas: alamatController.text,
                              );

                              context.read<PetugasBloc>().add(
                                    PetugasUpdateRequested(
                                      id: widget.petugas.idPetugas,
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
                    child: state is PetugasLoading
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
