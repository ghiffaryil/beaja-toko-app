import 'dart:io';

import 'package:beaja_toko/app.dart';
import 'package:beaja_toko/config/config.dart';
import 'package:beaja_toko/config/flavor_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHttpOverrides extends HttpOverrides {
  // HANDLE NOT SECURE CERTIFICATE
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  // LOAD ENV
  await dotenv.load(fileName: ".dev.env");

  // LOAD FLUTTER DOWNLOADER
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  HttpOverrides.global = MyHttpOverrides();

  // NOTIFICATION PLUGIN
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initSettings = InitializationSettings(android: android);
  flutterLocalNotificationsPlugin.initialize(initSettings);

  // Initialize your AppConfig
  final devAppConfig = AppConfig(
    appName: 'Beaja Toko Dev',
    flavor: FlavorType.dev,
  );

  // Initialize and run the app
  runApp(initializeApp(devAppConfig));
}
