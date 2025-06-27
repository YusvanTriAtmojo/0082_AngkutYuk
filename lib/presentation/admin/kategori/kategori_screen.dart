import 'package:angkut_yuk/data/model/response/get_all_kategori_response_model.dart';
import 'package:angkut_yuk/presentation/admin/bloc/kategori/kategori_bloc.dart';
import 'package:angkut_yuk/presentation/admin/kategori/kategori_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class KategoriScreen extends StatefulWidget {
  const KategoriScreen({super.key});

  @override
  State<KategoriScreen> createState() => _KategoriScreenState();
}

class _KategoriScreenState extends State<KategoriScreen> {
  @override
  void initState() {
    super.initState();
    context.read<KategoriBloc>().add(KategoriRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.ungubackgorund,
      body: BlocBuilder<KategoriBloc, KategoriState>(
        builder: (context, state) {
          if (state is KategoriLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is KategoriFailure) {
            return Center(child: Text('Gagal memuat data: ${state.error}'));
          } else if (state is KategoriLoaded) {
            final List<Kategori> kategoriList = state.listKategori;
            if (kategoriList.isEmpty) {
              return Center(child: Text("Belum ada kategori"));
            }
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: kategoriList.length,
              itemBuilder: (context, index) {
                final kategori = kategoriList[index];
                return Card(
                  color: Warna.unguMuda,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(Icons.category, color: Colors.white),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            kategori.namaKategori,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.white),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title: Text("Konfirmasi"),
                                    content: Text("Yakin ingin menghapus kategori ini?"),
                                    actions: [
                                      TextButton(
                                        child: Text("Batal"),
                                        onPressed: () => Navigator.of(dialogContext).pop(),
                                      ),
                                      TextButton(
                                        child: Text("Hapus", style: TextStyle(color: Colors.red)),
                                        onPressed: () {
                                          Navigator.of(dialogContext).pop();
                                          context.read<KategoriBloc>().add(KategoriDeleted(kategori.id));
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Halaman Kategori"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KategoriAddScreen()),
          ).then((result) {
            if (result == true) {
              context.read<KategoriBloc>().add(KategoriRequested());
            }
          });
        },
        backgroundColor: Warna.orange,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
