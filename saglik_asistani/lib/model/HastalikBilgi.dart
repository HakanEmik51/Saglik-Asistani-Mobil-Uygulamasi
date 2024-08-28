import 'dart:convert';

Hastalik? HastalikFromJson(String str) => Hastalik.fromJson(json.decode(str));

String HastalikToJson(Hastalik? data) => json.encode(data!.toJson());

class Hastalik {
  Hastalik(
      {required this.hastalik_ad,
      required this.gorsel,
      required this.hastalik_bilgi,
      required this.katagori,
      required this.poliklinik,
      required this.belirtileri});

  String? hastalik_ad;
  String? gorsel;
  String? hastalik_bilgi;
  String? katagori;
  String? poliklinik;
  String? belirtileri;

  factory Hastalik.fromJson(Map<String, dynamic> json) => Hastalik(
        hastalik_ad: json["hastalik_ad"],
        gorsel: json["gorsel"],
        hastalik_bilgi: json["hastalik_bigi"],
        katagori: json["katagori"],
        poliklinik: json["poliklinik"],
        belirtileri: json["belirtileri"],
      );

  Map<String, dynamic> toJson() => {
        "hastalik_ad": hastalik_ad,
        "gorsel": gorsel,
        "hastalik_bilgi": hastalik_bilgi,
        "katagori": katagori,
        "poliklinik": poliklinik,
        "belirtileri": belirtileri,
      };
}
