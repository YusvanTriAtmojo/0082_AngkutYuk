import 'package:angkut_yuk/presentation/auth/widget/register/register_button_function.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:angkut_yuk/presentation/auth/login_screen.dart';
import 'package:angkut_yuk/core/color/color.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final teleponController = TextEditingController();
  final alamatController = TextEditingController();

  bool isShowPassword = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    teleponController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: Warna.unguGradasi,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logistics.png', height: 100),
                const SizedBox(height: 40),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Nama',
                          prefixIcon: const Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan nama anda';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 16),

                      // Email
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan email';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 16),

                      // Password
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isShowPassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isShowPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                isShowPassword = !isShowPassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan password';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: teleponController,
                        decoration: InputDecoration(
                          hintText: 'No Telepon',
                          prefixIcon: const Icon(Icons.call),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan nomor telepon';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: alamatController,
                        decoration: InputDecoration(
                          hintText: 'Alamat',
                          prefixIcon: const Icon(Icons.home),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan alamat';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 30),
                      RegisterButtonFunction(
                        formKey: _formKey,
                        nameController: nameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        teleponController: teleponController,
                        alamatController: alamatController,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Sudah punya akun? "),
                          Text.rich(
                            TextSpan(
                              text: 'Login disini!',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const LoginScreen(),
                                      ),
                                    );
                                  },
                            ),
                          ),
                        ],
                      ),
                    ],
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
