import 'package:angkut_yuk/data/model/request/auth/register_request_model.dart';
import 'package:angkut_yuk/presentation/auth/bloc/register/register_bloc.dart';
import 'package:angkut_yuk/presentation/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:angkut_yuk/core/color/color.dart';

class RegisterButtonFunction extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController teleponController;
  final TextEditingController alamatController;

  const RegisterButtonFunction({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.teleponController,
    required this.alamatController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                state is RegisterLoading
                    ? null
                    : () {
                      if (formKey.currentState!.validate()) {
                        final request = RegisterRequestModel(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          notlpPelanggan: teleponController.text,
                          alamatPelanggan: alamatController.text,
                        );
                        context.read<RegisterBloc>().add(
                          RegisterRequested(requestModel: request),
                        );
                      }
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor: Warna.orange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              state is RegisterLoading ? "Memproses..." : "Daftar",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
