import 'dart:convert';

Kullanici kullaniciFromJson(String str) => Kullanici.fromJson(json.decode(str));

String kullaniciToJson(Kullanici data) => json.encode(data.toJson());

class Kullanici {
  Kullanici({
    required this.ad,
    required this.email,
    required this.id,
    required this.sifre,
    required this.soyad,
    required this.dogum_tarihi,
  });

  String ad;
  String email;
  String id;
  String sifre;
  String soyad;
  String dogum_tarihi;

  factory Kullanici.fromJson(Map<String, dynamic> json) => Kullanici(
        ad: json["ad"],
        email: json["email"],
        id: json["id"],
        sifre: json["sifre"],
        soyad: json["soyad"],
        dogum_tarihi: json["doğum_tarihi"],
      );

  Map<String, dynamic> toJson() => {
        "ad": ad,
        "email": email,
        "id": id,
        "sifre": sifre,
        "soyad": soyad,
        "doğum_tarihi": dogum_tarihi,
      };
}
