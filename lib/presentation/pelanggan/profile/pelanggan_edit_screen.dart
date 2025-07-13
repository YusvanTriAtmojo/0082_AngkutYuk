import 'package:angkut_yuk/data/model/request/pelanggan/pelanggan_request_model.dart';
import 'package:angkut_yuk/data/model/response/pelanggan_response_model.dart';
import 'package:angkut_yuk/presentation/pelanggan/bloc/pelanggan/pelanggan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class PelangganEditScreen extends StatefulWidget {
  final DataPelanggan pelanggan;

  const PelangganEditScreen({super.key, required this.pelanggan});

  @override
  State<PelangganEditScreen> createState() => _PelangganEditScreenState();
}

class _PelangganEditScreenState extends State<PelangganEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController namaController;
  late final TextEditingController notlpController;
  late final TextEditingController alamatController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(
      text: widget.pelanggan.namaPelanggan,
    );
    notlpController = TextEditingController(
      text: widget.pelanggan.notlpPelanggan,
    );
    alamatController = TextEditingController(
      text: widget.pelanggan.alamatPelanggan,
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    notlpController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.ungubackgorund,
      appBar: AppBar(
        title: Text("Edit Profil"),
        backgroundColor: Warna.ungu,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: BlocConsumer<PelangganBloc, PelangganState>(
        listener: (context, state) {
          if (state is PelangganUpdateSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context, true);
          } else if (state is PelangganFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text("Nama"),
                  TextFormField(
                    controller: namaController,
                    decoration: InputDecoration(
                      hintText: "Nama Pelanggan",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Warna.ungu, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama wajib diisi';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Text("Nomor Telepon"),
                  TextFormField(
                    controller: notlpController,
                    decoration: InputDecoration(
                      hintText: "No. Telepon",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Warna.ungu, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor Telepon wajib diisi';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Text("Alamat"),
                  TextFormField(
                    controller: alamatController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Alamat",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Warna.ungu, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat wajib diisi';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed:
                        state is PelangganLoading
                            ? null
                            : () {
                              if (_formKey.currentState!.validate()) {
                                final requestModel = PelangganRequestModel(
                                  namaPelanggan: namaController.text,
                                  notlpPelanggan: notlpController.text,
                                  alamatPelanggan: alamatController.text,
                                );

                                context.read<PelangganBloc>().add(
                                  UpdatePelangganRequested(
                                    requestModel: requestModel,
                                  ),
                                );
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Warna.ungu,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child:
                        state is PelangganLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                              "Simpan",
                              style: TextStyle(color: Colors.white),
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
