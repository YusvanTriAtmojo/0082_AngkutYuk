import 'dart:io';
import 'package:angkut_yuk/presentation/petugas/bloc/pesanan/pesanan_bloc.dart';
import 'package:angkut_yuk/presentation/petugas/map_page_petugas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:angkut_yuk/core/color/color.dart';
import 'package:image_picker/image_picker.dart';

class PetugasHome extends StatefulWidget {
  const PetugasHome({super.key});

  @override
  State<PetugasHome> createState() => _PetugasHomeState();
}

class _PetugasHomeState extends State<PetugasHome> {
  @override
  void initState() {
    super.initState();
    context.read<PesananPetugasBloc>().add(AmbilPesananAktifEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: Warna.unguGradasi,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocBuilder<PesananPetugasBloc, PesananState>(
          builder: (context, state) {
            if (state is PesananLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (state is PesananLoaded) {
              final pesananList = state.daftarPesanan;
              if (pesananList.isEmpty) {
                return Center(
                  child: Text(
                    "Tidak ada pesanan.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                itemCount: pesananList.length,
                itemBuilder: (context, index) {
                  final pesanan = pesananList[index];
                  final tanggal = DateFormat('dd MMM yyyy • HH:mm').format(pesanan.tanggalJemput!);
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _data(Icons.person, "Pelanggan", pesanan.pelanggan?.namaPelanggan ?? "-"),
                        SizedBox(height: 8),
                        _data(Icons.directions_car, "Kategori", pesanan.namaKategori),
                        SizedBox(height: 8),
                        _data(Icons.location_on, "Jemput", pesanan.alamatJemput),
                        SizedBox(height: 4),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (pesanan.latJemput != null && pesanan.lngJemput != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapePagePetugas(
                                    latitude: pesanan.latJemput!,
                                    longitude: pesanan.lngJemput!,
                                  ),
                                ),
                              );
                            }
                          },
                          label: Text("Lacak Jemput"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Warna.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        _data(Icons.flag, "Tujuan", pesanan.alamatTujuan),
                        SizedBox(height: 4),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (pesanan.latTujuan != null && pesanan.lngTujuan != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MapePagePetugas(
                                    latitude: pesanan.latTujuan!,
                                    longitude: pesanan.lngTujuan!,
                                  ),
                                ),
                              );
                            }
                          },
                          label: Text("Lacak Tujuan"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Warna.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        _data(Icons.calendar_today, "Tanggal", tanggal),
                        SizedBox(height: 8),
                        _data(Icons.attach_money, "Biaya", "Rp${pesanan.biaya}"),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.info_outline, size: 20, color: Colors.deepPurple),
                            SizedBox(width: 8),
                            Text(
                              pesanan.status,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Warna.orange,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Divider(),
                        SizedBox(height: 8),
                        Center(
                          child: Column(
                            children: [
                              if (pesanan.status != 'dalam_perjalanan') ...[
                                ElevatedButton.icon(
                                  onPressed: () {
                                    context.read<PesananPetugasBloc>().add(
                                      UbahStatusPesananEvent(
                                        idPesanan: pesanan.id,
                                        status: 'dalam_perjalanan',
                                      ),
                                    );
                                  },
                                  label: Text('Dalam Perjalanan'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Warna.orange,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                              ],
                              if (pesanan.status == 'dalam_perjalanan') ...[
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    final picker = ImagePicker();
                                    final pickedFile = await picker.pickImage(source: ImageSource.camera);
                            
                                    if (pickedFile != null) {
                                      final file = File(pickedFile.path);
                                      context.read<PesananPetugasBloc>().add(
                                        UploadBuktiSelesaiEvent(
                                          idPesanan: pesanan.id,
                                          fotoBukti: file,
                                        ),
                                      );
                                    }
                                  },
                                  label: Text('Upload Bukti Selesai'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Warna.ungu,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (state is PesananFailure) {
              return Center(
                child: Text(
                  "Gagal memuat data:\n${state.error}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  Widget _data(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.deepPurple),
        SizedBox(width: 8),
        Text("$label: ", 
        style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(value, 
          style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
