import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapePagePetugas extends StatefulWidget {
  final double latitude;   
  final double longitude;  

  const MapePagePetugas({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<MapePagePetugas> createState() => _MapePagePetugasState();
}

class _MapePagePetugasState extends State<MapePagePetugas> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _userLocation;
  Marker? _userMarker;
  Marker? _destinationMarker;
  CameraPosition? _cameraPosition;

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw 'Layanan lokasi tidak aktif.';

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) throw 'Izin lokasi ditolak.';
      }
      if (permission == LocationPermission.deniedForever) {
        throw 'Izin lokasi ditolak permanen.';
      }
      Position position = await Geolocator.getCurrentPosition();
      _userLocation = LatLng(position.latitude, position.longitude);

      _userMarker = Marker(
        markerId: const MarkerId("petugas"),
        position: _userLocation!,
        infoWindow: const InfoWindow(title: 'Lokasi Kamu'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );

      _destinationMarker = Marker(
        markerId: const MarkerId("tujuan"),
        position: LatLng(widget.latitude, widget.longitude),
        infoWindow: const InfoWindow(title: 'Lokasi Tujuan'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );

      _cameraPosition = CameraPosition(
        target: _userLocation!,
        zoom: 13,
      );

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mendapatkan lokasi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lacak Lokasi")),
      body: _cameraPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: _cameraPosition!,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) => _controller.complete(controller),
              markers: {
                if (_userMarker != null) _userMarker!,
                if (_destinationMarker != null) _destinationMarker!,
              },
            ),
    );
  }
}
