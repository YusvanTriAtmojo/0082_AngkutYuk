import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:angkut_yuk/core/color/color.dart';
import 'package:angkut_yuk/presentation/pelanggan/bloc/pesanan/pesanan_bloc.dart';
import 'package:angkut_yuk/presentation/pelanggan/pesanan/historypesanan_screen.dart';

class DataPesananScreen extends StatefulWidget {
  const DataPesananScreen({super.key});

  @override
  State<DataPesananScreen> createState() => _DataPesananScreenState();
}

class _DataPesananScreenState extends State<DataPesananScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PesananBloc>().add(AmbilPesananAktifEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesanan Aktif"),
        backgroundColor: Warna.ungu,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: Warna.unguGradasi,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocConsumer<PesananBloc, PesananState>(
          listener: (context, state) {
            if (state is PesananSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.pesan)),
              );
              context.read<PesananBloc>().add(AmbilPesananAktifEvent());
            }
          },
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
                    "Tidak ada pesanan aktif.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
              padding: EdgeInsets.all(16),
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
                      _data(Icons.directions_car, "Kategori", pesanan.namaKategori),
                      SizedBox(height: 8),
                      _data(Icons.location_on, "Jemput", pesanan.alamatJemput),
                      SizedBox(height: 8),
                      _data(Icons.flag, "Tujuan", pesanan.alamatTujuan),
                      SizedBox(height: 8),
                      _data(Icons.calendar_today, "Tanggal", tanggal),
                      SizedBox(height: 8),
                      _data(Icons.attach_money, "Biaya", "Rp${pesanan.biaya}"),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.info_outline, size: 20, color: Warna.ungu),
                          SizedBox(width: 8),
                          Text(
                            pesanan.status,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      if (pesanan.status.toLowerCase() == "pending") ...[
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text("Batalkan"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              context.read<PesananBloc>().add(HapusPesananEvent(pesanan.id));
                            },
                          ),
                        ),
                      ],
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

      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HistorypesananScreen()),
            );
            if (result == true) {
              context.read<PesananBloc>().add(AmbilPesananAktifEvent());
            }
          },
          backgroundColor: Warna.orange,
          child: Icon(Icons.history, size: 32, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _data(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.deepPurple),
        SizedBox(width: 8),
        Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
