import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/data/model/request/auth/login_request_model.dart';
import 'package:angkut_yuk/presentation/auth/bloc/login/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:angkut_yuk/presentation/admin/home/admin_screen.dart';
import 'package:angkut_yuk/presentation/petugas/home/petugas_screen.dart';
import 'package:angkut_yuk/presentation/pelanggan/home/pelanggan_screen.dart';
import 'package:angkut_yuk/core/color/color.dart';

class LoginButtonFunction extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  
  const LoginButtonFunction({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state is LoginSuccess) {
        final role = state.responseModel.user?.role;
        final name = state.responseModel.user?.name ?? '-';

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', name);

        if (!context.mounted) return; 

        if (role == 'admin') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => AdminScreen()),
            (route) => false,
          );
        } else if (role == 'petugas') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => PetugasScreen()),
            (route) => false,
          );
        } else if (role == 'pelanggan') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => PelangganScreen()),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Akun tidak dikenali')),
          );
        }
      }

      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state is LoginLoading
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      final request = LoginRequestModel(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      context.read<LoginBloc>().add(
                        LoginRequested(requestModel: request),
                      );
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Warna.orange,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              state is LoginLoading ? 'Memuat...' : 'Masuk',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}