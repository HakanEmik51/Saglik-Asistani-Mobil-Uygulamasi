import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:saglik_asistani/HastalikBilgiEkrani.dart';
import 'package:saglik_asistani/KullaniciProfil.dart';
import 'package:saglik_asistani/KullaniciProfilModel.dart';
import 'package:saglik_asistani/model/kullanici.dart';
import 'package:intl/intl.dart';

class KullaniciGuncelle extends StatefulWidget {
  State<KullaniciGuncelle> createState() => _KullaniciGuncellestate();
}

class _KullaniciGuncellestate extends State<KullaniciGuncelle> {
  TextEditingController _tarihController = TextEditingController();
  // DateTime dogum = DateTime(0, [0, 0] );
// Tarih seçmek için bir fonksiyon
  Future<DateTime?> _tarihsec(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        //_tarihsec=picked;
        _tarihController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    return picked;
  }

  Kullanici istenen = Kullanici(
    ad: "",
    email: "",
    id: "",
    sifre: "",
    soyad: "",
    dogum_tarihi: "",
  );
  List<Kullanici> kullanici = [];
  userDataFetch() async {
    var response =
        await FirebaseFirestore.instance.collection("kullanici").get();
    mapUser(response);
  }

  mapUser(QuerySnapshot<Map<String, dynamic>> response) {
    var records = response.docs
        .map(
          (item) => Kullanici(
              ad: item['ad'],
              email: item['email'],
              id: item['id'],
              sifre: item['sifre'],
              soyad: item['soyad'],
              dogum_tarihi: item['doğum_tarihi']),
        )
        .toList();

    setState(() {
      kullanici = records;
      for (int i = 0; i < kullanici.length; i++) {
        if (kullanici[i].id == FirebaseAuth.instance.currentUser?.uid) {
          setState(() {
            print("sayisi${kullanici.length}");

            istenen = kullanici[i];
          });
        }
      }
    });
  }

  void _sifredegistir(String password) async {
    User? user = await FirebaseAuth.instance.currentUser;

    user?.updatePassword(password).then((_) {
      print("Şifre değişti yeni şifre : $password");
    });
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _sifreController = TextEditingController();
  TextEditingController _adController = TextEditingController();
  TextEditingController _soyadController = TextEditingController();
  String changerMail = '';
  String changerSifre = '';
  String changerAd = '';
  String changerSoyad = '';
  String changerTarih = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataFetch();
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GuncelleProfil>(
      create: (_) => GuncelleProfil(),
      builder: (context, _) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan[100],
            title: const Text('Güncelle'),
            actions: [],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    //CircleAvatar(child: Icon(Icons.portable_wifi_off_outlined)),/// default foto koyalım!
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.09,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                changerMail = value;
                              });
                            },
                            controller: _emailController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.mail,
                                  color: Colors.cyan[100],
                                ),
                                border: InputBorder.none,
                                hintText: 'E-mail'),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.09,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                changerSifre = value;
                              });
                            },
                            controller: _sifreController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.key_outlined,
                                  color: Colors.cyan[100],
                                ),
                                border: InputBorder.none,
                                hintText: 'Şifre'),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.09,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                changerTarih = value;
                              });
                            },
                            controller: _tarihController,
                            decoration: InputDecoration(
                                icon: IconButton(
                                    icon: Icon(Icons.date_range),
                                    color: Colors.cyan[100],
                                    onPressed: () => _tarihsec(context)),
                                border: InputBorder.none,
                                hintText: 'Doğum Tarihi Seçin'),
                            onTap: () {
                              _tarihsec(context);
                            },
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.09,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                changerAd = value;
                              });
                            },
                            controller: _adController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.account_circle,
                                  color: Colors.cyan[100],
                                ),
                                border: InputBorder.none,
                                hintText: "Yeni ad giriniz"),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.09,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                changerSoyad = value;
                              });
                            },
                            controller: _soyadController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.account_circle,
                                  color: Colors.cyan[100],
                                ),
                                border: InputBorder.none,
                                hintText: "Yeni soyad giriniz"),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.09,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(30)),
                      child: ElevatedButton(
                        onPressed: () async {
                          await context
                              .read<GuncelleProfil>()
                              .KullaniciGuncelle(
                                  ad: changerAd,
                                  email: changerMail,
                                  sifre: changerSifre,
                                  soyad: changerSoyad,
                                  dogum_tarihi:
                                      _tarihController.text.toString());

                          _sifredegistir(_sifreController.text);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.white,
                              content: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                  ),
                                  Text(
                                    'Kaydınız başarıyla güncellendi',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.cyan[100], // Butonun arka plan rengi
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            //side: BorderSide(width: 3, color: Colors.white),
                          ),
                          // Diğer stil özellikleri buraya eklenebilir
                        ),
                        child: Text('Güncelle'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
