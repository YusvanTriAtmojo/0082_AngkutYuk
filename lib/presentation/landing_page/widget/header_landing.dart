import 'package:angkut_yuk/presentation/auth/login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:angkut_yuk/core/color/color.dart';

class HeaderLanding extends StatelessWidget {
  const HeaderLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 180,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: Warna.unguGradasi,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logistics.png', height: 60),
              const SizedBox(width: 15),
              const Text(
                'AngkutYuk',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Warna.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text('Sign In'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Solusi pengiriman barang cepat & aman',
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
                speed: const Duration(milliseconds: 50),
              ),
            ],
            totalRepeatCount: 3,
            pause: const Duration(milliseconds: 900),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ],
      ),
    );
  }
}