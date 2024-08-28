//import 'dart:html';
//import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

import 'package:saglik_asistani/model/Ilac.dart';
//import '../model/kullanici.dart';

class IlacEkle extends ChangeNotifier {
  Future<void> ekleIlac(
      {required String Kid,
      required String ilacad,
      required String doz,
      required String tip,
      required String aralik,
      required String saat,
      required String dakika}) async {
    var yeniIlac = Ilac(
      Kid: Kid,
      IlacAd: ilacad,
      doz: doz,
      tip: tip,
      aralik: aralik,
      saat: saat,
      dakika: dakika,
    );
    try {
      await FirebaseFirestore.instance
          .collection("İlaclar")
          .add(yeniIlac.toJson());
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> silIlacAd(String ilacAd) async {
    try {
      // İlaçları adlarına göre sorgula
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("İlaclar")
          .where("IlacAd", isEqualTo: ilacAd)
          .get();

      // Sorgudan dönen belgeleri kontrol et
      querySnapshot.docs.forEach((doc) async {
        // Her belgeyi sırayla sil
        await FirebaseFirestore.instance
            .collection("İlaclar")
            .doc(doc.id)
            .delete();
      });

      print("$ilacAd adlı ilaç(lar) başarıyla silindi.");
    } catch (e) {
      print("İlaç(lar) silinirken bir hata oluştu: $e");
    }
  }
}
