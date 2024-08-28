import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class KayitOlModel extends ChangeNotifier {
  Future<void> newUser(
      {required String email,
      required String sifre,
      required String ad,
      required String soyad}) async {
    // burada verileri çekme metodu kullan eğer true dönerse böyle hesap vardır gibisinden sonra bu kayıt başarılı olamasın
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: sifre)
        .then((value) {
      FirebaseFirestore.instance
          .collection('kullanici')
          .doc(value.user?.uid)
          .set({
        "email": email,
        "sifre": sifre,
        "id": value.user?.uid,
        "ad": ad,
        "soyad": soyad,
        "doğum_tarihi": "doğum_tarihi",
      });
    });
    print("Kayıt Eklendi");
  }
}
