class DoktorEkle {
  DoktorEkle({
    required this.ad,
    required this.bolum,
    required this.soyad,
    required this.id,
  });

  String ad;
  String bolum;
  String soyad;
  String id;

  factory DoktorEkle.fromJson(Map<String, dynamic> json) => DoktorEkle(
        ad: json["ad"],
        bolum: json["bolum"],
        soyad: json["soyad"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "ad": ad,
        "bolum": bolum,
        "soyad": soyad,
        "id": id,
      };
}
