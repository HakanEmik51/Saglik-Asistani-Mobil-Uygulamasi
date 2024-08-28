//import 'dart:convert';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';

class Ilac {
  Ilac({
    required this.Kid,
    required this.IlacAd,
    required this.doz,
    required this.tip,
    required this.aralik,
    required this.saat,
    required this.dakika,
  });
  String Kid;
  String IlacAd;
  String doz;
  String tip;
  String aralik;
  String saat;
  String dakika;

  factory Ilac.fromJson(Map<String, dynamic> json) => Ilac(
        Kid: json["Kid"],
        IlacAd: json["IlacAd"],
        doz: json["doz"],
        tip: json["tip"],
        aralik: json["aralik"],
        saat: json["saat"],
        dakika: json["dakika"],
      );

  Map<String, dynamic> toJson() => {
        "Kid": Kid,
        "IlacAd": IlacAd,
        "doz": doz,
        "tip": tip,
        "aralik": aralik,
        "saat": saat,
        "dakika": dakika,
      };
}
