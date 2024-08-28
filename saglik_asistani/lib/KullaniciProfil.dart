import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:saglik_asistani/KullaniciGuncelle.dart';
import 'package:saglik_asistani/KullaniciProfilModel.dart';
import 'package:saglik_asistani/model/kullanici.dart';
import 'package:saglik_asistani/widgets/info_card.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profilestate();
}

class _profilestate extends State<profile> {
  List<Kullanici> kullanici = [];
  Kullanici istenen = Kullanici(
    ad: "",
    email: "",
    id: "",
    sifre: "",
    soyad: "",
    dogum_tarihi: "",
  );
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

  void _showDialog(BuildContext context,
      {required String title, required String msg}) {
    final Dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        // RaisedButton(
        //   color: Colors.teal,
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   child: Text(
        //     'Close',
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        // )
      ],
    );
    showDialog(context: context, builder: (x) => Dialog);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataFetch();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GuncelleProfil>(
      create: (_) => GuncelleProfil(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[100],
          title: Text('Profilim'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Text(
                  istenen.ad.toUpperCase() + "  " + istenen.soyad.toUpperCase(),
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.blueGrey[200],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Profil Bilgi',
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.blueGrey[200],
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Source Sans Pro'),
                ),
                SizedBox(
                  height: 30,
                  width: 200,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                InfoCard(
                  text: istenen.email,
                  icon: Icons.email,
                  onPressed: () async {},
                ),
                SizedBox(
                  height: 10,
                ),
                InfoCard(
                  text: istenen.dogum_tarihi,
                  icon: Icons.date_range,
                  onPressed: () async {},
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 320,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan[100]),
                  child: TextButton(
                    onPressed: () async {
                      Get.to(KullaniciGuncelle());
                    },
                    child: Text("Güncelle"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 320,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.cyan[100]),
                  child: TextButton(
                    onPressed: () async {
                      await context.read<GuncelleProfil>().signOut();
                    },
                    child: Text("Çıkış yap"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
