import 'package:angkut_yuk/core/color/color.dart';
import 'package:angkut_yuk/presentation/auth/register_screen.dart';
import 'package:angkut_yuk/presentation/landing_page/widget/header_landing.dart';
import 'package:flutter/material.dart';
import 'package:angkut_yuk/presentation/landing_page/widget/benefit.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.ungubackgorund,
      body: Column(
        children: [
          const HeaderLanding(),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/delivtruck.png',
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                    fit: BoxFit.contain,
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha((0.85 * 255).toInt()),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Jasa Angkut Barang\nCepat & Terpercaya',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Warna.ungu,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Pindahan, kirim barang besar, semua bisa langsung dari HP Anda.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Benefit(),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Warna.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
