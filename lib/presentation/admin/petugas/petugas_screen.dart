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
  String selectedStatus = 'Semua';

  @override
  void initState() {
    super.initState();
    context.read<PetugasBloc>().add(PetugasRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.ungubackgorund,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/sopir.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(color: Warna.ungubackgorund.withAlpha(191)),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        setState(() => selectedStatus = value);
                        if (value.toLowerCase() == 'semua') {
                          context.read<PetugasBloc>().add(PetugasRequested());
                        } else {
                          context
                              .read<PetugasBloc>()
                              .add(FilterStatusPetugas(value));
                        }
                      },
                      offset: Offset(0, 40),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Warna.unguMuda,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(selectedStatus, style: TextStyle(fontSize: 12)),
                            Icon(Icons.arrow_drop_down, size: 18),
                          ],
                        ),
                      ),
                      itemBuilder: (context) => ['Semua', 'tersedia', 'bertugas']
                          .map((status) => PopupMenuItem<String>(
                                value: status,
                                child: Text(
                                  status,
                                  style: TextStyle(color: Warna.ungu),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Expanded(
                  child: BlocBuilder<PetugasBloc, PetugasState>(
                    builder: (context, state) {
                      if (state is PetugasLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is PetugasFailure) {
                        return Center(child: Text('Gagal memuat data: ${state.error}'));
                      } else if (state is PetugasLoaded || state is PetugasFiltered) {
                        final petugasList = state is PetugasLoaded
                            ? state.listPetugas
                            : (state as PetugasFiltered).filteredPetugas;

                        final filtered = selectedStatus == 'Semua'
                            ? petugasList
                            : petugasList
                                .where((p) =>
                                    p.statusPetugas.toLowerCase() ==
                                    selectedStatus.toLowerCase())
                                .toList();

                        if (filtered.isEmpty) {
                          return Center(child: Text("Tidak ada petugas"));
                        }

                        return ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final petugas = filtered[index];
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
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Warna.unguMuda,
                                  borderRadius: BorderRadius.circular(12),
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
                                    Icon(Icons.arrow_forward_ios,
                                        size: 16, color: Colors.white),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Center(child: Text("Halaman Petugas"));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PetugasAddScreen()),
          );
          if (result == true) {
            context.read<PetugasBloc>().add(PetugasRequested());
          }
        },
        backgroundColor: Warna.orange,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}