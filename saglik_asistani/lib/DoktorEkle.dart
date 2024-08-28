import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:saglik_asistani/DoktorEkleModel.dart';
import 'package:saglik_asistani/model/DoktorEkle.dart';
import 'package:saglik_asistani/model/doktor.dart';

class DoktorEkleme extends StatefulWidget {
  @override
  State<DoktorEkleme> createState() => _DoktorEklemeState();
}

class _DoktorEklemeState extends State<DoktorEkleme> {
  List<DoktorEkle> _doktorlar = [];
  fetchdoktorlarData() async {
    var response = await FirebaseFirestore.instance.collection("doktor").get();
    mapHastalik(response);
  }

  mapHastalik(QuerySnapshot<Map<String, dynamic>> response) {
    var records = response.docs
        .map(
          (item) => DoktorEkle(
            ad: item['ad'],
            bolum: item['bolum'],
            soyad: item['soyad'],
            id: item['id'],
          ),
        )
        .toList();
    setState(() {
      _doktorlar = records;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdoktorlarData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DoktorEkleModel>(
      create: (_) => DoktorEkleModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[100],
          title: Text('Doktorlar'),
          automaticallyImplyLeading: true,
          centerTitle: true,
        ),
        body: Container(
          height: _doktorlar.length * 100,
          width: double.infinity,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _doktorlar.length,
            itemBuilder: (BuildContext context, int index) {
              Color? renk = index % 2 == 0
                  ? Color.fromARGB(255, 243, 238, 245)
                  : Colors.cyan[100];
              return Column(
                children: [
                  Container(
                    color: renk,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ListTile(
                              title: Center(
                                child: Text(_doktorlar[index].ad.toUpperCase() +
                                    ' ' +
                                    _doktorlar[index].soyad.toUpperCase()),
                              ),
                              subtitle: Center(
                                  child: Text(_doktorlar[index].bolum ?? '')),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: FloatingActionButton(
                              elevation: 4,
                              backgroundColor: Colors.cyan[100],
                              mini: true,
                              child: Icon(
                                Icons.add,
                              ),
                              onPressed: () async {
                                await context
                                    .read<DoktorEkleModel>()
                                    .ekledoktor(
                                      kullanici_id: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      ad: _doktorlar[index].ad,
                                      soyad: _doktorlar[index].soyad,
                                      bolum: _doktorlar[index].bolum,
                                      id: _doktorlar[index].id,
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
