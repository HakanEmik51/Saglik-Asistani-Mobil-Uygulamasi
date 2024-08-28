import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:saglik_asistani/BaslangicEkrani.dart';
import 'package:saglik_asistani/utils.dart';
import 'firebase_options.dart';
//import 'BaslangicEkrani.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await registerService();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const BaslangicEkrani(),
    );
  }
}
