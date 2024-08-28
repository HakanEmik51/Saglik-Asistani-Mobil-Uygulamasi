//import 'dart:html';
//import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

import 'package:saglik_asistani/model/Ilac.dart';
import 'package:saglik_asistani/model/doktor.dart';
//import '../model/kullanici.dart';

class DoktorEkleModel extends ChangeNotifier {
  Future<void> ekledoktor({
    required String kullanici_id,
    required String ad,
    required String soyad,
    required String bolum,
    required String id,
  }) async {
    var yeniDoktor = Doktor(
      kullanici_id: kullanici_id,
      ad: ad,
      soyad: soyad,
      bolum: bolum,
      id: id,
    );
    try {
      await FirebaseFirestore.instance
          .collection("doktorlarım")
          .add(yeniDoktor.toJson());
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> silDoktorAd(String doktorAd) async {
    try {
      // İlaçları adlarına göre sorgula
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("doktorlarım")
          .where("ad", isEqualTo: doktorAd)
          .get();

      // Sorgudan dönen belgeleri kontrol et
      querySnapshot.docs.forEach((doc) async {
        // Her belgeyi sırayla sil
        await FirebaseFirestore.instance
            .collection("doktorlarım")
            .doc(doc.id)
            .delete();
      });

      print("$doktorAd adlı ilaç(lar) başarıyla silindi.");
    } catch (e) {
      print("İlaç(lar) silinirken bir hata oluştu: $e");
    }
  }
}
