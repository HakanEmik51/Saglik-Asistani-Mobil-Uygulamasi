import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/base/path_point.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saglik_asistani/BaslangicEkrani.dart';
import 'package:saglik_asistani/GirisEkrani.dart';
import 'package:saglik_asistani/KullaniciGuncelle.dart';
import 'package:saglik_asistani/model/kullanici.dart';

class GuncelleProfil extends ChangeNotifier {
  Future<void> KullaniciGuncelle(
      {required String ad,
      required String email,
      required String sifre,
      required String soyad,
      required String dogum_tarihi}) async {
    var Guncelkullanici = Kullanici(
        ad: ad,
        email: email,
        id: FirebaseAuth.instance.currentUser!.uid,
        sifre: sifre,
        soyad: soyad,
        dogum_tarihi: dogum_tarihi);
    await FirebaseFirestore.instance
        .collection('kullanici')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update(Guncelkullanici.toJson());
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.to(BaslangicEkrani());
  }
}
