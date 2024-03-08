// ignore_for_file: use_build_context_synchronously

import 'package:beaja_toko/common/constants/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void getPermissionLocation(BuildContext context) async {
  bool serviceStatus = await Geolocator.isLocationServiceEnabled();

  if (serviceStatus) {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Location Permissions Required'),
            content: const Text(
                'Please grant location permissions to use this app.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  permission = await Geolocator.requestPermission();
                  if (permission == LocationPermission.denied) {
                    showToast(message: 'Location permissions are denied');
                  } else if (permission == LocationPermission.deniedForever) {
                    showToast(
                        message: 'Location permissions are permanently denied');
                  } else {}
                },
                child: const Text('Grant'),
              ),
            ],
          );
        },
      );
    } else {}
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('GPS Service Required'),
          content: const Text(
              'Please enable GPS location services to use this app.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
