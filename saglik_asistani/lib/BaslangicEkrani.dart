import 'package:flutter/material.dart';
import 'package:saglik_asistani/DoktorGiris.dart';
import 'package:saglik_asistani/KayitOl.dart';
//import 'package:untitled3/regScreen.dart';

import 'GirisEkrani.dart';

class BaslangicEkrani extends StatelessWidget {
  const BaslangicEkrani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 194, 231, 241),
          Color.fromARGB(255, 82, 222, 229),
        ])),
        child: SingleChildScrollView(
          child: Column(children: [
            const Padding(
                padding: EdgeInsets.only(top: 110.0),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image(image: AssetImage("assets/app_logo.png")),
                )),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Hoş Geldiniz',
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GirisEkrani()));
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: const Center(
                  child: Text(
                    'HASTA GİRİŞ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const KayitOl()));
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: const Center(
                  child: Text(
                    'KAYIT OL',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const doktorgiris()));
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: const Center(
                  child: Text(
                    'DOKTOR GİRİŞ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
