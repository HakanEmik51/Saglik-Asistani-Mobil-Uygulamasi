import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:saglik_asistani/DoktorEkle.dart';
import 'package:saglik_asistani/DoktorEkleModel.dart';
import 'package:saglik_asistani/Hastalik.dart';
import 'package:saglik_asistani/chatEkrani.dart';
import 'package:saglik_asistani/database_service.dart';
import 'package:saglik_asistani/model/doktor.dart';
import 'package:get_it/get_it.dart';
import 'package:saglik_asistani/navigation_service.dart';

class DoktorGoruntu extends StatefulWidget {
  @override
  State<DoktorGoruntu> createState() => _DoktorGoruntuState();
}

class _DoktorGoruntuState extends State<DoktorGoruntu> {
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;
  late NavigationService _navigationService;
  List<Doktor> _doktorlarim = [];
  fetchdoktorlarimData(String kullanici_id) async {
    var response = await FirebaseFirestore.instance
        .collection("doktorlarım")
        .where('kullanici_id', isEqualTo: kullanici_id)
        .get();
    mapHastalik(response);
  }

  mapHastalik(QuerySnapshot<Map<String, dynamic>> response) {
    var records = response.docs
        .map(
          (item) => Doktor(
            ad: item['ad'],
            bolum: item['bolum'],
            kullanici_id: item['kullanici_id'],
            soyad: item['soyad'],
            id: item['id'],
          ),
        )
        .toList();
    setState(() {
      _doktorlarim = records;
    });
  }

  @override
  void initState() {
    super.initState();
    _databaseService = _getIt.get<DatabaseService>();
    _navigationService = _getIt.get<NavigationService>();
    fetchdoktorlarimData(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DoktorEkleModel>(
      create: (_) => DoktorEkleModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[100],
          title: Text('Doktorlarım'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 4,
          backgroundColor: Colors.cyan[100],
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoktorEkleme(),
              ),
            );
          },
        ),
        body: _doktorlarim.length > 0
            ? Container(
                height: _doktorlarim.length * 100,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _doktorlarim.length,
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
                                      child: Text(
                                          _doktorlarim[index].ad.toUpperCase() +
                                              ' ' +
                                              _doktorlarim[index]
                                                  .soyad
                                                  .toUpperCase()),
                                    ),
                                    subtitle: Center(
                                        child: Text(
                                            _doktorlarim[index].bolum ?? '')),
                                    onTap: () async {
                                      final chatExists =
                                          await _databaseService.chatSec(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              _doktorlarim[index].id);
                                      if (!chatExists) {
                                        await _databaseService.createNewChat(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            _doktorlarim[index].id);
                                      }
                                      Get.to(chatEkrani(
                                          chatUser: _doktorlarim[index]));
                                      // _navigationService.push(
                                      //   MaterialPageRoute(builder: (context) {
                                      //     return chatEkrani(
                                      //       chatUser: _doktorlarim[index],
                                      //     );
                                      //   }),
                                      // );
                                      print("girdiiiiiii");
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () async {
                                      await context
                                          .read<DoktorEkleModel>()
                                          .silDoktorAd(_doktorlarim[index].ad);
                                      setState(() {
                                        fetchdoktorlarimData(FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString());
                                      });
                                    },
                                    icon: Icon(Icons.clear),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ))
            : Container(
                color: Color(0xFFF6F8FC),
                child: const Center(
                  child: Text(
                    "Doktor Eklemek İçin + Butonuna Basınız",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFFC9C9C9),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
      ),
    );
  }
}
