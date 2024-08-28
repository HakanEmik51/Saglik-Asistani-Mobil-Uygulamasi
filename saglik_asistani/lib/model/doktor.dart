class Doktor {
  Doktor({
    required this.kullanici_id,
    required this.ad,
    required this.bolum,
    required this.soyad,
    required this.id,
  });
  String kullanici_id;
  String ad;
  String bolum;
  String soyad;
  String id;

  factory Doktor.fromJson(Map<String, dynamic> json) => Doktor(
        kullanici_id: json["kullanici_id"],
        ad: json["ad"],
        bolum: json["bolum"],
        soyad: json["soyad"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "kullanici_id": kullanici_id,
        "ad": ad,
        "bolum": bolum,
        "soyad": soyad,
        "id": id,
      };
}
