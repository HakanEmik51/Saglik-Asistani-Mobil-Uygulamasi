import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saglik_asistani/GirisEkraniModel.dart';
import 'package:provider/provider.dart';
//import 'package:lottie/lottie.dart';

class GirisEkrani extends StatelessWidget {
  const GirisEkrani({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _sifre = TextEditingController();

    return ChangeNotifierProvider<GirisEkraniModel>(
      create: (_) => GirisEkraniModel(),
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
                  'Merhaba Giriş yapın!',
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
                    padding: EdgeInsets.only(top: 150, left: 20, right: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
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
                          height: 30,
                        ),
                        TextFormField(
                          controller: _sifre,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
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
                              var response = await FirebaseFirestore.instance
                                  .collection("kullanici")
                                  .where("email", isEqualTo: _email.text)
                                  .where("sifre", isEqualTo: _sifre.text)
                                  .limit(1)
                                  .get();
                              //if (kDebugMode) {
                              //print("email----------------------------------" +
                              //  _email.text);
                              // }
                              if (response.docs.isNotEmpty) {
                                // sayfaya yönlendirme
                                //signIn();
                                await context.read<GirisEkraniModel>().signIn(
                                    email: _email.text, sifre: _sifre.text);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 170,
                                      width: 170,
                                      child: AlertDialog(
                                        content: Container(
                                          height: 170,
                                          width: 170,
                                          child: Column(
                                            children: [
                                              Text(
                                                'Kullanıcı Bulunamadı',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              Container(
                                                height: 50,
                                                width: 50,
                                              ),
                                              Text('Geçersiz email/şifre'),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Kapat')),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: Text("Giriş Yap",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
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
