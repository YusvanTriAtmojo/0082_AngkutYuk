import 'package:angkut_yuk/presentation/pelanggan/bloc/pesanan/pesanan_bloc.dart';
import 'package:angkut_yuk/presentation/pelanggan/pesanan/detailpesanan_screen.dart';
import 'package:angkut_yuk/presentation/pelanggan/pesanan/pilihtanggal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:angkut_yuk/data/model/request/pelanggan/pesanan_request_model.dart';
import 'package:angkut_yuk/presentation/map_page.dart';
import 'package:angkut_yuk/core/color/color.dart';

class FormPesananScreen extends StatefulWidget {
  final int idKategori;
  final String namaKategori;

  const FormPesananScreen({
    super.key,
    required this.idKategori,
    required this.namaKategori,
  });

  @override
  State<FormPesananScreen> createState() => _FormPesananScreenState();
}

class _FormPesananScreenState extends State<FormPesananScreen> {
  final _formKey = GlobalKey<FormState>();
  final alamatJemputController = TextEditingController();
  final alamatTujuanController = TextEditingController();

  DateTime? tanggalJemput;
  double? latJemput;
  double? lngJemput;
  double? latTujuan;
  double? lngTujuan;

  @override
  void dispose() {
    alamatJemputController.dispose();
    alamatTujuanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PesananBloc, PesananState>(
        listener: (context, state) {
          if (state is BiayaHitungSuccess) {
            final pesanan = PesananRequestModel(
              alamatJemput: alamatJemputController.text,
              latJemput: latJemput!,
              lngJemput: lngJemput!,
              alamatTujuan: alamatTujuanController.text,
              latTujuan: latTujuan!,
              lngTujuan: lngTujuan!,
              jarakKm: state.jarakKm,
              biaya: state.biaya,
              tanggalJemput: DateFormat('yyyy-MM-dd HH:mm:ss').format(tanggalJemput!),
              idKategori: widget.idKategori,
              namaKategori: widget.namaKategori,
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPesananScreen(pesanan: pesanan),
              ),
            );
          } else if (state is PesananFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: Warna.unguGradasi,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Form Pesanan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        widget.namaKategori,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Warna.orange,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: alamatJemputController,
                          readOnly: true,
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MapPage()),
                            );
                            if (result != null && result is Map) {
                              setState(() {
                                alamatJemputController.text = result['alamat'];
                                latJemput = result['lat'];
                                lngJemput = result['lng'];
                              });
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Alamat Jemput',
                            prefixIcon: Icon(Icons.map, color: Warna.orange),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            errorStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Alamat Jemput wajib diisi';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: alamatTujuanController,
                          readOnly: true,
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MapPage()),
                            );
                            if (result != null && result is Map) {
                              setState(() {
                                alamatTujuanController.text = result['alamat'];
                                latTujuan = result['lat'];
                                lngTujuan = result['lng'];
                              });
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Alamat Tujuan',
                            prefixIcon: Icon(Icons.map, color: Warna.orange),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            errorStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Alamat Tujuan wajib diisi';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tanggal Jemput',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                tanggalJemput == null
                                    ? 'Belum dipilih'
                                    : DateFormat('dd MMMM yyyy • HH:mm').format(tanggalJemput!),
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              ElevatedButton.icon(
                                onPressed: () {
                                  showCustomCupertinoDateTimePicker(
                                    context: context,
                                    currentDateTime: tanggalJemput,
                                    onDateSelected: (selected) {
                                      setState(() {
                                        tanggalJemput = selected;
                                      });
                                    },
                                  );
                                },
                                icon: Icon(Icons.calendar_today, color: Colors.white),
                                label: Text('Tanggal'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Warna.orange,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (latJemput == null || lngJemput == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Alamat jemput belum dipilih')),
                                );
                                return;
                              }
                              if (latTujuan == null || lngTujuan == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Alamat tujuan belum dipilih')),
                                );
                                return;
                              }
                              if (tanggalJemput == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Tanggal jemput wajib diisi')),
                                );
                                return;
                              }

                              context.read<PesananBloc>().add(HitungBiayaEvent(
                                    latJemput: latJemput!,
                                    lngJemput: lngJemput!,
                                    latTujuan: latTujuan!,
                                    lngTujuan: lngTujuan!,
                                  ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Warna.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                          ),
                          child: Text('Buat Pesanan', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
