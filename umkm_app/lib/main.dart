import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/views/umkm_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UMKM App',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const UmkmView(),
    );
  }
}
