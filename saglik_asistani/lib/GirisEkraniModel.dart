// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:saglik_asistani/BaslangicEkrani.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saglik_asistani/HastalikBilgiEkrani.dart';

class GirisEkraniModel extends ChangeNotifier {
  User? _user;
  User? get user {
    return _user;
  }

  Future<void> signIn({
    required String email,
    required String sifre,
  }) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: sifre);
    if (credential.user != null) {
      _user = credential.user;
      // return true;
    }
    Get.to(HastalikBilgiEkrani());
  }
}
