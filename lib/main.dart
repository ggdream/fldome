import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:fldome/app/app.dart';
import 'package:flutter/material.dart';

void main() {
  DartVLC.initialize();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
