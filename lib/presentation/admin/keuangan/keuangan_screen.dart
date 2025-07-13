import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';
import 'package:angkut_yuk/presentation/admin/bloc/pesanan/pesanan_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class KeuanganScreen extends StatefulWidget {
  const KeuanganScreen({super.key});

  @override
  State<KeuanganScreen> createState() => _KeuanganScreenState();
}

class _KeuanganScreenState extends State<KeuanganScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PesananAdminBloc>().add(AmbilSemuaPesananAdminEvent());
  }

  Future<void> _downloadPDF(List pesananSelesai, int totalPendapatan) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Text('Laporan Keuangan', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 16),
          pw.Text(
            'Total Pendapatan: Rp ${NumberFormat("#,##0", "id_ID").format(totalPendapatan)}',
            style: pw.TextStyle(fontSize: 16, color: PdfColor.fromInt(0xff4CAF50)),
          ),
          pw.SizedBox(height: 16),
          pw.TableHelper.fromTextArray(
            headers: ['Nama Pelanggan', 'Tujuan', 'Kategori', 'Biaya'],
            data: pesananSelesai.map<List<String>>((pesanan) {
              return [
                pesanan.pelanggan?.namaPelanggan ?? '-',
                pesanan.alamatTujuan ?? '-',
                pesanan.namaKategori ?? '-',
                'Rp ${NumberFormat("#,##0", "id_ID").format(pesanan.biaya ?? 0)}',
              ];
            }).toList(),
          ),
        ],
      ),
    );

    final status = await Permission.storage.request();
    if (status.isGranted) {
      final directory = Directory('/storage/emulated/0/Download');
      final path = '${directory.path}/laporan_keuangan.pdf';
      final file = File(path);
      await file.writeAsBytes(await pdf.save());

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF berhasil disimpan di: $path')),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Izin penyimpanan ditolak')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.ungubackgorund,
      body: BlocBuilder<PesananAdminBloc, PesananAdminState>(
        builder: (context, state) {
          if (state is PesananAdminLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PesananAdminLoaded) {
            final pesananSelesai = state.daftarPesanan
                .where((p) => p.status.toLowerCase() == 'selesai')
                .toList();

            if (pesananSelesai.isEmpty) {
              return const Center(child: Text("Tidak ada data keuangan."));
            }

            int totalPendapatan = pesananSelesai.fold(0, (sum, item) => sum + (item.biaya));

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Pendapatan:\nRp ${NumberFormat("#,##0", "id_ID").format(totalPendapatan)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _downloadPDF(pesananSelesai, totalPendapatan);
                        },
                        icon: Icon(Icons.download),
                        label: Text("Download PDF"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Warna.orange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: pesananSelesai.length,
                    itemBuilder: (context, index) {
                      final pesanan = pesananSelesai[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(pesanan.pelanggan?.namaPelanggan ?? 'Nama tidak tersedia'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tujuan: ${pesanan.alamatTujuan}"),
                              Text("Kategori: ${pesanan.namaKategori}"),
                            ],
                          ),
                          trailing: Text(
                            "Rp ${NumberFormat("#,##0", "id_ID").format(pesanan.biaya)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is PesananAdminFailure) {
            return Center(child: Text("Gagal memuat data: ${state.error}"));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
