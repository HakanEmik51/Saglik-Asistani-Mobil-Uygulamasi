import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:saglik_asistani/BaslangicEkrani.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saglik_asistani/HastalikBilgiEkrani.dart';
import 'package:saglik_asistani/kullanici_g%C3%B6r%C3%BCnt%C3%BCle.dart';

class DoktorGirisModel extends ChangeNotifier {
  Future<void> signIn({
    required String email,
    required String sifre,
  }) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: sifre);

    Get.to(KullaniciGoruntu());
  }
}
