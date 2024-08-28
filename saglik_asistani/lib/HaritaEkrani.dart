import 'dart:async';

//import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HaritaEkrani extends StatefulWidget {
  const HaritaEkrani({super.key});

  @override
  State<HaritaEkrani> createState() => _HaritaEkraniState();
}

class _HaritaEkraniState extends State<HaritaEkrani> {
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  LatLng? _currentP = null;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor markerIcon2 = BitmapDescriptor.defaultMarker;
  void konum_icon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/marker.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  void hastane_icon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/hospital.png")
        .then(
      (icon) {
        setState(() {
          markerIcon2 = icon;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    konum_icon();
    hastane_icon();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        title: Text('Hastane Konumları'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: _currentP!,
              ),
              markers: {
                Marker(
                    infoWindow: InfoWindow(title: "Konum"),
                    markerId: MarkerId("_currentLocation"),
                    position: _currentP!,
                    icon: markerIcon),
                Marker(
                    infoWindow: InfoWindow(
                        title:
                            "Necmettin Erbakan Üniversitesi Meram Tıp Fakültesi"),
                    markerId: MarkerId("meram"),
                    position: LatLng(37.88816266197759, 32.43316832140057),
                    icon: markerIcon2),
                Marker(
                  infoWindow: InfoWindow(title: "MERAM DEVLET HASTANESİ"),
                  markerId: MarkerId("_destionationLocation"),
                  icon: markerIcon2,
                  position: LatLng(37.86286499559828, 32.44483204852934),
                ),
                Marker(
                  infoWindow: InfoWindow(title: "MERAM NUMUNE HASTANESİ"),
                  markerId: MarkerId("_destionationLocation"),
                  icon: markerIcon2,
                  position: LatLng(37.88067323884342, 32.49011447101182),
                ),
                Marker(
                  infoWindow:
                      InfoWindow(title: "BEYHEKİM AĞIZ VE DİŞ SAĞLIĞI MERKEZİ"),
                  markerId: MarkerId("_destionationLocation"),
                  icon: markerIcon2,
                  position: LatLng(37.872624646828086, 32.48625135203415),
                ),
              },
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 11.50,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }
}
