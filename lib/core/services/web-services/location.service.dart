import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import '../../../UI/base/base.vm.dart';

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}

class LocationViewModel extends BaseViewModel {
  String apiKey = 'AIzaSyA43d-GqtStG6UtRLU8kxz_wnbl9hkE70M';

  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];

  bool positionStreamStarted = false;
  double? latitude;
  double? longitude;

  void _updatePositionList(_PositionItemType type, String displayValue) {
    _positionItems.add(_PositionItem(type, displayValue));
    notifyListeners();
  }

  Future<bool?> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      _updatePositionList(
        _PositionItemType.log,
        _kLocationServicesDisabledMessage,
      );

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        _updatePositionList(
          _PositionItemType.log,
          _kPermissionDeniedMessage,
        );

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      _updatePositionList(
        _PositionItemType.log,
        _kPermissionDeniedForeverMessage,
      );

      return false;
    }

    if (permission == LocationPermission.whileInUse) {
      return true;
    }

    if (permission == LocationPermission.always) {
      return true;
    }
    return false;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    print(hasPermission);

    if (hasPermission == null || hasPermission == false) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    print(position);
    print(position.latitude);
    print(position.longitude);

    latitude = position.latitude;
    longitude = position.longitude;

    if (userService.isUserLoggedIn) {
      await sendLocation(
          latitude: latitude.toString(), longitude: longitude.toString());
    }

    notifyListeners();
  }

  sendLocation({required String latitude, required String longitude}) async {
    try {
      var response = await repository.sendLocation(
          latitude: latitude, longitude: longitude);
      print("Just Here ${jsonEncode(response)}");
    } catch (err) {
      print(" THE ERROR $err");
    }
  }

  Future<String> getLocationFromCoordinates(
      double latitude, double longitude) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    try {
      Dio dio = Dio();
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'OK') {
          return data['results'][0]['formatted_address'];
        } else {
          return 'Location not found';
        }
      } else {
        return 'Failed to fetch location';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  // LocationViewModel(){
  //   _getCurrentPosition();
  // }
}
