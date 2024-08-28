import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:saglik_asistani/GirisEkraniModel.dart';
import 'package:provider/provider.dart';
import 'package:saglik_asistani/KayitOlModel.dart';

class KayitOl extends StatelessWidget {
  const KayitOl({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _sifre = TextEditingController();
    TextEditingController _ad = TextEditingController();
    TextEditingController _soyad = TextEditingController();
    TextEditingController _dogum_tarih = TextEditingController();
    List sayilar = ["0", "1", "2", "3", " 4", "5", "6", "7", "8", "9"];
    bool kontrol() {
      if (_email.text.length == 0 ||
          _sifre.text.length == 0 ||
          _ad.text.length == 0 ||
          _soyad.text.length == 0) {
        return true;
      }
      return false;
    }

    bool kontrolEmail(String email) {
      for (int i = 0; i < email.length; i++) {
        if (email[i] == '@') {
          return true;
        }
      }
      return false;
    }

    bool adKontrol(String ad) {
      for (int i = 0; i < ad.length; i++) {
        for (int j = 0; j < sayilar.length; j++) {
          if (ad[i] == sayilar[j]) {
            return false;
          }
        }
      }
      return true;
    }

    bool soyadKontrol(String soyad) {
      for (int i = 0; i < soyad.length; i++) {
        for (int j = 0; j < sayilar.length; j++) {
          if (soyad[i] == sayilar[j]) {
            return false;
          }
        }
      }
      return true;
    }

    return ChangeNotifierProvider<KayitOlModel>(
      create: (_) => KayitOlModel(),
      builder: (context, _) => Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 194, 231, 241),
                    Color.fromARGB(255, 82, 222, 229),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 100, left: 50),
                child: const Text(
                  'Merhaba kayıt olun!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 200),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 90, left: 20, right: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _ad,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 178, 235, 242),
                              ),
                            ),
                            labelText: "Ad",
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Adınızı Giriniz";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _soyad,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 178, 235, 242),
                              ),
                            ),
                            labelText: "Soyad",
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Soyad  Giriniz";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 178, 235, 242),
                              ),
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email Giriniz";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _sifre,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 178, 235, 242),
                              ),
                            ),
                            labelText: "Şifre",
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Şifre Giriniz";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 50),
                        Container(
                          width: 320,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 194, 231, 241),
                                Color.fromARGB(255, 82, 222, 229),
                              ],
                            ),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              if (kontrol()) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.blue,
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.warning,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                          'E-mail,Şifre,Ad-Soyad eksiksiz girilmelidir'),
                                    ],
                                  ),
                                  duration: Duration(seconds: 1),
                                ));
                                //print(_visible);
                              } else {
                                if (kontrolEmail(_email.text) &&
                                    adKontrol(_ad.text) &&
                                    soyadKontrol(_soyad.text)) {
                                  //newUser();
                                  await context.read<KayitOlModel>().newUser(
                                      email: _email.text.trim(),
                                      sifre: _sifre.text.trim(),
                                      ad: _ad.text.trim(),
                                      soyad: _soyad.text.trim());

                                  //changeVisible();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                            'Yeni Kullanıcı Hesabı Oluşturuldu'),
                                      ],
                                    ),
                                    duration: Duration(seconds: 1),
                                  ));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 170,
                                          width: 150,
                                          child: AlertDialog(
                                            content: Container(
                                              height: 130,
                                              width: 100,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                  Text(
                                                      'Hatalı email,ad veya soyad formatı'),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('Kapat')),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                              }
                            },
                            child: Text(
                              "Kayıt Ol",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
