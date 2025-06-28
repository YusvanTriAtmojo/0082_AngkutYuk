import 'package:angkut_yuk/data/model/response/get_all_petugas_response_model.dart';
import 'package:angkut_yuk/presentation/admin/bloc/petugas/petugas_bloc.dart';
import 'package:angkut_yuk/presentation/admin/petugas/petugas_add_screen.dart';
import 'package:angkut_yuk/presentation/admin/petugas/petugas_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class PetugasScreen extends StatefulWidget {
  const PetugasScreen({super.key});

  @override
  State<PetugasScreen> createState() => _PetugasScreenState();
}

class _PetugasScreenState extends State<PetugasScreen> {
  
  @override
  void initState() {
    super.initState();
    context.read<PetugasBloc>().add(PetugasRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/sopir.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
              color: Warna.ungubackgorund.withAlpha(191),
          ),
          BlocBuilder<PetugasBloc, PetugasState>(
            builder: (context, state) {
              if (state is PetugasLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PetugasFailure) {
                return Center(child: Text('Gagal memuat data: ${state.error}'));
              } else if (state is PetugasLoaded) {
                final List<Petugas> petugasList = state.listPetugas;
                if (petugasList.isEmpty) {
                  return Center(child: Text("Belum ada petugas"));
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: petugasList.length,
                  itemBuilder: (context, index) {
                    final petugas = petugasList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PetugasDetailScreen(petugas: petugas),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Warna.unguMuda,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person_pin_rounded, color: Colors.white),
                            SizedBox(width: 16),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    petugas.namaPetugas,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    petugas.notlpPetugas,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text("Halaman Petugas"));
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PetugasAddScreen()),
          ).then((result) {
            if (result == true) {
              context.read<PetugasBloc>().add(PetugasRequested());
            }
          });
        },
        backgroundColor: Warna.orange ,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}