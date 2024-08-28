import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:saglik_asistani/BaslangicEkrani.dart';
import 'package:saglik_asistani/DoktorEkle.dart';
import 'package:saglik_asistani/DoktorEkleModel.dart';
import 'package:saglik_asistani/Hastalik.dart';
import 'package:saglik_asistani/chatEkrani.dart';
import 'package:saglik_asistani/chatEkrani2.dart';
import 'package:saglik_asistani/database_service.dart';
import 'package:saglik_asistani/model/chat.dart';
import 'package:saglik_asistani/model/doktor.dart';
import 'package:get_it/get_it.dart';
import 'package:saglik_asistani/model/kullanici.dart';
import 'package:saglik_asistani/navigation_service.dart';

class KullaniciGoruntu extends StatefulWidget {
  @override
  State<KullaniciGoruntu> createState() => _KullaniciGoruntuState();
}

class _KullaniciGoruntuState extends State<KullaniciGoruntu> {
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;
  late NavigationService _navigationService;

  List<Kullanici> _kullanicilar = [];

  fetchKullaniciData() async {
    var response =
        await FirebaseFirestore.instance.collection("kullanici").get();
    mapKullanici(response);
  }

  mapKullanici(QuerySnapshot<Map<String, dynamic>> response) {
    var records = response.docs.map((item) {
      return Kullanici(
        ad: item['ad'],
        soyad: item['soyad'],
        id: item['id'],
        email: item['email'],
        sifre: item['sifre'],
        dogum_tarihi: item['doğum_tarihi'],
      );
    }).toList();

    setState(() {
      _kullanicilar = records;
    });
  }

  @override
  void initState() {
    super.initState();
    _databaseService = _getIt.get<DatabaseService>();
    _navigationService = _getIt.get<NavigationService>();
    fetchKullaniciData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[100],
          title: Text('Hastalar'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.to(BaslangicEkrani());
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Container(
            height: _kullanicilar.length * 100,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _kullanicilar.length,
              itemBuilder: (BuildContext context, int index) {
                Color? renk = index % 2 == 0
                    ? Color.fromARGB(255, 243, 238, 245)
                    : Colors.cyan[100];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: renk,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: ListTile(
                                title: Center(
                                  child: Text(_kullanicilar[index]
                                          .ad
                                          .toUpperCase() +
                                      ' ' +
                                      _kullanicilar[index].soyad.toUpperCase()),
                                ),
                                subtitle: Center(),
                                onTap: () async {
                                  final chatExists =
                                      await _databaseService.chatSec(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          _kullanicilar[index].id);
                                  if (!chatExists) {
                                    await _databaseService.createNewChat(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        _kullanicilar[index].id);
                                  }
                                  print(_kullanicilar[index].id);
                                  Get.to(chatEkrani2(
                                      chatUser: _kullanicilar[index]));
                                  // _navigationService.push(
                                  //   MaterialPageRoute(builder: (context) {
                                  //     return chatEkrani2(
                                  //       chatUser: _kullanicilar[index],
                                  //     );
                                  //   }),
                                  // );
                                  print("girdiiiiiii");
                                },
                              ),
                            ),
                            // Expanded(
                            //   child: IconButton(
                            //     onPressed: () async {
                            //       await context
                            //           .read<DoktorEkleModel>()
                            //           .silDoktorAd(_doktorlarim[index].ad);
                            //       setState(() {
                            //         fetchdoktorlarimData(FirebaseAuth
                            //             .instance.currentUser!.uid
                            //             .toString());
                            //       });
                            //     },
                            //     icon: Icon(Icons.clear),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ))
        // : Container(
        //     color: Color(0xFFF6F8FC),
        //     child: const Center(
        //       child: Text(
        //         "Doktor Eklemek İçin + Butonuna Basınız",
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //             fontSize: 24,
        //             color: Color(0xFFC9C9C9),
        //             fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //   ),
        );
  }
}
