import 'dart:io';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';

class PhoneService {
  // --------------------------- Geo Location--------------------
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // ---------------------- Network --------------------------
  final Connectivity _connectivity = Connectivity();

  // Check network type once
  Future<String> checkNetworkType() async {
    final List<ConnectivityResult> results = await _connectivity
        .checkConnectivity();
    return _getNetworkTypeString(results);
  }

  // Helper method to parse connectivity results
  String _getNetworkTypeString(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      return 'Wi-Fi';
    } else if (results.contains(ConnectivityResult.mobile)) {
      return 'Mobile Data';
    } else if (results.contains(ConnectivityResult.ethernet)) {
      return 'Ethernet';
    } else if (results.contains(ConnectivityResult.none)) {
      return 'No Internet Connection';
    }
    return 'Unknown Network';
  }

  // Stream to listen for network state changes in real time
  Stream<List<ConnectivityResult>> get onNetworkChanged =>
      _connectivity.onConnectivityChanged;

  // ---------------------------- Battery ------------------------
  final Battery _battery = Battery();

  Future<int> getBatteryLevel() async {
    final level = await _battery.batteryLevel;
    return level;
  }

  // -------------------------- Device Model ------------------------
  Future<String> getDeviceModel() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      // e.g., "Pixel 7" or "SM-G998B"
      return '${androidInfo.manufacturer} ${androidInfo.model}';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      // e.g., "iPhone14,2" or "iPhone"
      return iosInfo.utsname.machine;
    }

    return 'Unsupported Platform';
  }
}
