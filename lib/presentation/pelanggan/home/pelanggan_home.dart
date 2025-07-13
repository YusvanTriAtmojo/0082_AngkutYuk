import 'package:angkut_yuk/core/color/color.dart';
import 'package:angkut_yuk/presentation/pelanggan/pesanan/datapesanan_screen.dart';
import 'package:angkut_yuk/presentation/pelanggan/pesanan/historypesanan_screen.dart';
import 'package:angkut_yuk/presentation/pelanggan/pesanan/pilihkategori_screen.dart';
import 'package:flutter/material.dart';

class PelangganHome extends StatelessWidget {
  const PelangganHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: Warna.unguGradasi,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/logistics.png",
                    height: 120,
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KategoriKendaraanScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.add_shopping_cart),
                    label: Text("Pesan Kendaraan"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Warna.orange,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Menu Layanan",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DataPesananScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Warna.orange,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.track_changes, color: Warna.ungu),
                            SizedBox(height: 8),
                            Text("Lacak Pesanan", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HistorypesananScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Warna.orange,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.history, color: Warna.ungu),
                            SizedBox(height: 8),
                            Text("Riwayat", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  "Mengapa memilih AngkutYuk?",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(25),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer, color: Warna.orange, size: 20),
                          SizedBox(width: 8),
                          Text("Cepat dan Tepat Waktu", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.security, color: Warna.orange, size: 20),
                          SizedBox(width: 8),
                          Text("Aman dan Terpercaya", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.attach_money, color: Warna.orange, size: 20),
                          SizedBox(width: 8),
                          Text("Harga Terjangkau", style: TextStyle(color: Colors.white)),
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
