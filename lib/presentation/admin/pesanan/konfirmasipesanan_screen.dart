import 'package:angkut_yuk/data/model/request/admin/pesanan_request_model.dart';
import 'package:angkut_yuk/presentation/admin/bloc/kendaraan/kendaraan_bloc.dart';
import 'package:angkut_yuk/presentation/admin/bloc/pesanan/pesanan_bloc.dart';
import 'package:angkut_yuk/presentation/admin/bloc/petugas/petugas_bloc.dart';
import 'package:angkut_yuk/presentation/admin/home/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class KonfirmasipesananScreen extends StatefulWidget {
  final int idPesanan;

  const KonfirmasipesananScreen({super.key, required this.idPesanan});

  @override
  State<KonfirmasipesananScreen> createState() => _KonfirmasipesananScreenState();
}

class _KonfirmasipesananScreenState extends State<KonfirmasipesananScreen> {
  int? selectedKendaraanId;
  int? selectedPetugasId;
  int? idKategori;
  bool _hasPopped = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<KendaraanBloc>().add(KendaraanRequested());
    context.read<PetugasBloc>().add(PetugasRequested());
    context.read<PesananAdminBloc>().add(AmbilDetailPesananAdminEvent(widget.idPesanan));
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final request = AdminPesananRequestModel(
        idKendaraan: selectedKendaraanId,
        petugasId: selectedPetugasId,
        status: "disetujui",
        statusPetugas: "bertugas",
        statusKendaraan: "terpakai",
      );

      context.read<PesananAdminBloc>().add(UpdatePesananAdminEvent(
        id: widget.idPesanan,
        request: request,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pilih kendaraan dan petugas terlebih dahulu")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.ungubackgorund,
      appBar: AppBar(
        title: Text("Konfirmasi Pesanan"),
        backgroundColor: Warna.ungu,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminScreen()),
            );
          },
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PesananAdminBloc, PesananAdminState>(
            listener: (context, state) {
              if (state is PesananAdminSuccess && !_hasPopped) {
                _hasPopped = true;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AdminScreen()),
                );
              } else if (state is PesananAdminFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Gagal: ${state.error}")),
                );
              } else if (state is DetailPesananAdminLoaded) {
                idKategori = state.pesanan.idKategori;
                if (idKategori != null) {
                  context.read<KendaraanBloc>().add(FilterKendaraanByKategori(idKategori!));
                }
              }
            },
          ),
        ],
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                BlocBuilder<PesananAdminBloc, PesananAdminState>(
                  builder: (context, state) {
                    if (state is PesananAdminLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is DetailPesananAdminLoaded) {
                      final pesanan = state.pesanan;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Detail Pesanan", style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text("Nama Pelanggan: ${pesanan.pelanggan?.namaPelanggan ?? '-'}"),
                          Text("Alamat Jemput: ${pesanan.alamatJemput}"),
                          Text("Alamat Tujuan: ${pesanan.alamatTujuan}"),
                          Text("Kategori: ${pesanan.namaKategori}"),
                          Text("Jarak: ${pesanan.jarakKm} km"),
                          Text("Biaya: ${pesanan.biaya} rupiah"),
                          SizedBox(height: 24),
                        ],
                      );
                    } else if (state is PesananAdminFailure) {
                      return Text("Gagal memuat detail pesanan: ${state.error}");
                    }
                    return SizedBox.shrink();
                  },
                ),
                Text("Pilih Kendaraan"),
                SizedBox(height: 8),
                BlocBuilder<KendaraanBloc, KendaraanState>(
                  builder: (context, state) {
                    if (state is KendaraanLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is KendaraanFiltered || state is KendaraanLoaded) {
                      final kendaraanList = (state is KendaraanFiltered)
                          ? state.filteredKendaraan
                          : (state as KendaraanLoaded).listKendaraan;
                      return DropdownButtonFormField<int>(
                        value: selectedKendaraanId,
                        items: kendaraanList.map((kendaraan) {
                          return DropdownMenuItem(
                            value: kendaraan.idKendaraan,
                            child: Text("${kendaraan.namaKendaraan} - ${kendaraan.platNomor}"),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => selectedKendaraanId = val),
                        validator: (value) => value == null ? 'Kendaraan wajib dipilih' : null,
                        decoration: InputDecoration(
                          hintText: "Pilih Kendaraan",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Warna.ungu, width: 2),
                          ),
                        ),
                      );
                    } else if (state is KendaraanFailure) {
                      return Text("Gagal memuat kendaraan: ${state.error}");
                    }
                    return SizedBox.shrink();
                  },
                ),
                SizedBox(height: 16),
                Text("Pilih Petugas"),
                SizedBox(height: 8),
                BlocBuilder<PetugasBloc, PetugasState>(
                  builder: (context, state) {
                    if (state is PetugasLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is PetugasFiltered || state is PetugasLoaded) {
                      final petugasList = (state is PetugasFiltered)
                          ? state.filteredPetugas
                          : (state as PetugasLoaded)
                              .listPetugas
                              .where((p) => p.statusPetugas.toLowerCase() == 'tersedia')
                              .toList();
                      return DropdownButtonFormField<int>(
                        value: selectedPetugasId,
                        items: petugasList.map((petugas) {
                          return DropdownMenuItem(
                            value: petugas.idPetugas,
                            child: Text(petugas.namaPetugas),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => selectedPetugasId = val),
                        validator: (value) => value == null ? 'Petugas wajib dipilih' : null,
                        decoration: InputDecoration(
                          hintText: "Pilih Petugas",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Warna.ungu, width: 2),
                          ),
                        ),
                      );
                    } else if (state is PetugasFailure) {
                      return Text("Gagal memuat petugas: ${state.error}");
                    }
                    return SizedBox.shrink();
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Warna.ungu,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Konfirmasi',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
