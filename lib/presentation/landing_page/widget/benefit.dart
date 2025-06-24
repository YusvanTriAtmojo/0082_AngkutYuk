import 'package:flutter/material.dart';
import 'package:angkut_yuk/core/color/color.dart';

class Benefit extends StatelessWidget {
  const Benefit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 90.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(Icons.verified, color: Warna.ungu, size: 20),
              SizedBox(width: 8),
              Text('Mitra Terverifikasi', style: TextStyle(fontSize: 14)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.inventory, color: Warna.ungu, size: 20),
              SizedBox(width: 8),
              Text('Keamanan barang terjaga', style: TextStyle(fontSize: 14)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.price_check, color: Warna.ungu, size: 20),
              SizedBox(width: 8),
              Text('Harga Transparan', style: TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}