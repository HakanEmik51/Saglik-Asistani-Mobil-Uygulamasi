import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglik_asistani/BaslangicEkrani.dart';
import 'package:saglik_asistani/DoktorG%C3%B6r%C3%BCnt%C3%BCle.dart';
import 'package:saglik_asistani/HaritaEkrani.dart';
import 'package:saglik_asistani/Hastalik.dart';
import 'package:saglik_asistani/IlacTakipEkrani.dart';
import 'package:saglik_asistani/KullaniciProfil.dart';
//import 'package:saglik_asistani/KayitOl.dart';

import 'package:saglik_asistani/model/HastalikBilgi.dart';
import 'package:saglik_asistani/model/Ilac.dart';
import 'package:saglik_asistani/nobetci_eczane.dart';
import '../model/kullanici.dart';

class HastalikBilgiEkrani extends StatefulWidget {
  @override
  State<HastalikBilgiEkrani> createState() =>
      _HastalikBilgiEkranistate(); //mail);
}

class _HastalikBilgiEkranistate extends State<HastalikBilgiEkrani>
    with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser;
  //  final User? user = Auth().currentUser;
  //  Future<void> signOut() async {
  //    await Auth().signOut();
  //  }

  int _currentIndex = 0;
  String info = '';

  var _tcontroller = TextEditingController();

  bool _touched = true;
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

  List<Hastalik> _hastalikler = [];
  fetchHastalikData() async {
    var response =
        await FirebaseFirestore.instance.collection("hastalik_bilgi").get();
    mapHastalik(response);
  }

  mapHastalik(QuerySnapshot<Map<String, dynamic>> response) {
    var records = response.docs
        .map(
          (item) => Hastalik(
            gorsel: item['gorsel'],
            hastalik_ad: item['hastalik_ad'],
            hastalik_bilgi: item['hastalik_bilgi'],
            katagori: item['katagori'],
            poliklinik: item['poliklinik'],
            belirtileri: item['belirtileri'],
          ),
        )
        .toList();
    setState(() {
      _hastalikler = records;
    });
  }

  List<Hastalik> empty = [];
  Ad_arama(String input) {
    empty = [];
    for (int i = 0; i < _hastalikler.length; i++) {
      if (_hastalikler[i].hastalik_ad == input) {
        empty.add(_hastalikler[i]);
      }
    }
  }

  katagori_arama(String input) {
    empty = [];
    for (int i = 0; i < _hastalikler.length; i++) {
      if (_hastalikler[i].katagori == input) {
        empty.add(_hastalikler[i]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHastalikData();
    userDataFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex != 0
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
              backgroundColor: _touched
                  ? Colors.cyan[100]
                  : Color.fromARGB(255, 243, 238, 245),
              title: _touched
                  ? Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        'sağlıkla kal!!',
                        style: TextStyle(fontSize: 20),
                      ))
                  : Container(
                      margin: EdgeInsets.only(left: 30),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'hastalık ara',
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        controller: _tcontroller,
                        onChanged: (value) {
                          if (value.length > 4) {
                            setState(() {
                              Ad_arama(value);
                            });
                          }
                        },
                      )),
              actions: _touched
                  ? [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _touched = !_touched;
                            });
                          },
                          icon: Icon(Icons.search))
                    ]
                  : [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _touched = !_touched;
                            });
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                          ))
                    ],
            ),
      backgroundColor: Color.fromARGB(255, 243, 238, 245),
      body: _currentIndex != 0
          ? Center(
              child: _currentIndex == 1
                  ? HaritaEkrani()
                  : _currentIndex == 2
                      ? IlacTakip()
                      : _currentIndex == 3
                          ? NobetciEczane()
                          : _currentIndex == 4
                              ? DoktorGoruntu()
                              : profile())
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: _touched
                  ? Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.080,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Merhaba  " + istenen.ad.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 30,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Text(
                            'Katagoriler',
                            style: TextStyle(fontSize: 20),
                          ),
                          Divider(
                              thickness: 3,
                              color: Colors.blue,
                              endIndent:
                                  MediaQuery.of(context).size.width * 0.33,
                              indent: MediaQuery.of(context).size.width * 0.33),
                          Container(
                            width: double.infinity,
                            height: 110,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  width: 85,
                                  child: Column(
                                    children: [
                                      Card(
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _touched = !_touched;
                                                _tcontroller.text = 'Akciğer';
                                                katagori_arama(
                                                    _tcontroller.text);
                                                print(_touched);
                                              });
                                            },
                                            child: Image.asset(
                                              'assets/akciğer.png',
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      Text('Akciğer')
                                    ],
                                  ),
                                ),
                                Container(
                                    width: 85,
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Card(
                                              child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _touched = !_touched;
                                                      _tcontroller.text =
                                                          'Karaciğer';
                                                      katagori_arama(
                                                          _tcontroller.text);
                                                      print(_touched);
                                                    });
                                                  },
                                                  child: Image.asset(
                                                    'assets/karaciğer.png',
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                            Text('Karaciğer')
                                          ],
                                        ),
                                      ],
                                    )),
                                Container(
                                  width: 85,
                                  child: Column(
                                    children: [
                                      Card(
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _touched = !_touched;
                                                _tcontroller.text = 'Beyin';
                                                katagori_arama(
                                                    _tcontroller.text);
                                                print(_touched);
                                              });
                                            },
                                            child: Image.asset(
                                              'assets/beyin.png',
                                              fit: BoxFit.cover,
                                            )), // değişecek
                                      ),
                                      Text('Beyin')
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 85,
                                  child: Column(
                                    children: [
                                      Card(
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _touched = !_touched;
                                                  _tcontroller.text = 'Kalp';
                                                  katagori_arama(
                                                      _tcontroller.text);
                                                  print(_touched);
                                                });
                                              },
                                              child: Image.asset(
                                                'assets/kalp.png',
                                                fit: BoxFit.cover,
                                              ))),
                                      Text('Kalp')
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 85,
                                  child: Column(
                                    children: [
                                      Card(
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _touched = !_touched;
                                                _tcontroller.text =
                                                    'Safra kesesi';
                                                katagori_arama(
                                                    _tcontroller.text);
                                                print(_touched);
                                              });
                                            },
                                            child: Image.asset(
                                              'assets/safra kesesi.png',
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      Text('Safra kesesi')
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 85,
                                  child: Column(
                                    children: [
                                      Card(
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _touched = !_touched;
                                                _tcontroller.text = 'Kulak';
                                                katagori_arama(
                                                    _tcontroller.text);
                                                print(_touched);
                                              });
                                            },
                                            child: Image.asset(
                                              'assets/kulak.png',
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      Text('Kulak')
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 85,
                                  child: Column(
                                    children: [
                                      Card(
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _touched = !_touched;
                                                _tcontroller.text = 'Böbrek';
                                                katagori_arama(
                                                    _tcontroller.text);
                                                print(_touched);
                                              });
                                            },
                                            child: Image.asset(
                                              'assets/böbrek.png',
                                              fit: BoxFit.cover,
                                            )), // değişecek
                                      ),
                                      Text('Böbrek')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                'Hastalıklar',
                                style: TextStyle(fontSize: 20),
                              )),
                            ],
                          ),
                          Divider(
                              thickness: 3,
                              color: Colors.blue,
                              endIndent:
                                  MediaQuery.of(context).size.width * 0.3,
                              indent: MediaQuery.of(context).size.width * 0.3),
                          Container(
                            color: Colors.cyan[50],

                            width: double.infinity,
                            height: _hastalikler.length *
                                80, // itemcount*10 DİYE AYARLA!!!
                            child: _hastalikler.length > 0
                                ? ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: _hastalikler.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(_hastalikler[index]
                                                    .hastalik_ad ??
                                                ''),
                                            subtitle: Text(
                                                _hastalikler[index].katagori ??
                                                    ''),
                                            onTap: () {
                                              Get.to(Hastalik2(
                                                  _hastalikler[index]));
                                            },
                                            leading: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  child: Image.asset(
                                                      '${_hastalikler[index].gorsel}')),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: empty.length * 90,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: empty.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title:
                                          Text(empty[index].hastalik_ad ?? ''),
                                      subtitle:
                                          Text(empty[index].katagori ?? ''),
                                      onTap: () {
                                        Get.to(Hastalik2(empty[index]));
                                      },
                                      leading: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,
                                          child: Image.asset(
                                              '${empty[index].gorsel}')),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
            ),
      bottomNavigationBar: Container(
        height: 70,
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (int newIndex) {
            setState(() {
              fetchHastalikData();
              userDataFetch();

              // fetchSepettData();
              // chooseKullanici();
              // fetchSiparisData();
              // fetchYorumData();

              Duration(seconds: 1);
              _currentIndex = newIndex;
            });
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                color: Colors.cyan,
              ),
              icon: Icon(Icons.home_outlined),
              label: 'Anasayfa',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.local_hospital,
                color: Colors.cyan,
              ),
              icon: Icon(Icons.local_hospital_outlined),
              label: 'Hastane konum',
            ),
            NavigationDestination(
              // selectedIcon: Icon(
              //   Icons.local_pharmacy,
              //   color: Colors.cyan,
              // ),
              selectedIcon: Icon(
                Icons.medical_services,
                color: Colors.cyan,
              ),
              icon: Icon(Icons.medical_services_outlined),
              label: 'İlaç Takip',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.local_pharmacy,
                color: Colors.cyan,
              ),
              icon: Icon(Icons.local_pharmacy_outlined),
              label: 'Nöbetci Eczane',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.chat,
                color: Colors.cyan,
              ),
              icon: Icon(Icons.chat_bubble_outline),
              label: 'sohbet',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.person,
                color: Colors.cyan,
              ),
              icon: Icon(Icons.person_outline),
              label: 'Profilim',
            ),
          ],
        ),
      ),
    );
  }
}
