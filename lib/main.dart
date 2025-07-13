import 'package:angkut_yuk/data/repository/auth_repository.dart';
import 'package:angkut_yuk/data/repository/kategori_repository.dart';
import 'package:angkut_yuk/data/repository/kendaraan_repository.dart';
import 'package:angkut_yuk/data/repository/pelanggan_repository.dart';
import 'package:angkut_yuk/data/repository/pesanan_repository.dart';
import 'package:angkut_yuk/data/repository/petugas_repository.dart';
import 'package:angkut_yuk/presentation/admin/bloc/kategori/kategori_bloc.dart';
import 'package:angkut_yuk/presentation/admin/bloc/kendaraan/kendaraan_bloc.dart';
import 'package:angkut_yuk/presentation/admin/bloc/pesanan/pesanan_bloc.dart';
import 'package:angkut_yuk/presentation/admin/bloc/petugas/petugas_bloc.dart';
import 'package:angkut_yuk/presentation/pelanggan/bloc/pelanggan/pelanggan_bloc.dart';
import 'package:angkut_yuk/presentation/pelanggan/bloc/pesanan/pesanan_bloc.dart';
import 'package:angkut_yuk/presentation/auth/bloc/login/login_bloc.dart';
import 'package:angkut_yuk/presentation/auth/bloc/register/register_bloc.dart';
import 'package:angkut_yuk/presentation/landing_page/landing_screen.dart';
import 'package:angkut_yuk/presentation/petugas/bloc/pesanan/pesanan_bloc.dart';
import 'package:angkut_yuk/presentation/petugas/bloc/petugas/petugas_bloc.dart';
import 'package:angkut_yuk/services/service_http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LoginBloc(authRepository: AuthRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) =>
              RegisterBloc(authRepository: AuthRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) =>
              KategoriBloc(kategoriRepository: KategoriRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) =>
              KendaraanBloc(kendaraanRepository: KendaraanRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) =>
              PetugasBloc(petugasRepository: PetugasRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) =>
              PelangganBloc(pelangganRepository: PelangganRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) =>
              PesananBloc(pesananrepository: PesananRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) =>
              PesananAdminBloc(pesananrepository: PesananRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) =>
              PesananPetugasBloc(pesananrepository: PesananRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) =>
              PetugasprofilBloc(petugasRepository: PetugasRepository(ServiceHttpClient())),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const LandingScreen(),
      ),
    );
  }
}
