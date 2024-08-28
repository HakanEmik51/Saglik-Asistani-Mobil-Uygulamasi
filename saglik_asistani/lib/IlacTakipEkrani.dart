//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:saglik_asistani/IlacEkleme.dart';
import 'package:saglik_asistani/IlacEklemeModel.dart';
//import 'package:saglik_asistani/KayitOl.dart';
import 'package:saglik_asistani/model/Ilac.dart';

class IlacTakip extends StatefulWidget {
  @override
  State<IlacTakip> createState() => _IlacTakipState();
}

class _IlacTakipState extends State<IlacTakip> {
  List<Ilac> object = [];
  fetchilacData(String Kid1) async {
    var response = await FirebaseFirestore.instance
        .collection("İlaclar")
        .where("Kid", isEqualTo: Kid1)
        .get();
    mapilac(response);
  }

  mapilac(QuerySnapshot<Map<String, dynamic>> response) {
    var records = response.docs
        .map(
          (item) => Ilac(
            Kid: item['Kid'],
            IlacAd: item['IlacAd'],
            tip: item['tip'],
            doz: item['doz'],
            aralik: item['aralik'],
            saat: item['saat'],
            dakika: item['dakika'],
          ),
        )
        .toList();
    setState(
      () {
        object = records;
      },
    );
  }

  Hero makeIcon(double size, int index) {
    if (object[index].tip == "Şurup") {
      return Hero(
        tag: object[index].IlacAd + object[index].tip,
        child: Icon(
          IconData(0xe900, fontFamily: "Ic"),
          color: Color(0xFF3EB16F),
          size: size,
        ),
      );
    } else if (object[index].tip == "Hap") {
      return Hero(
        tag: object[index].IlacAd + object[index].tip,
        child: Icon(
          IconData(0xe901, fontFamily: "Ic"),
          color: Color(0xFF3EB16F),
          size: size,
        ),
      );
    } else if (object[index].tip == "Şırınga") {
      return Hero(
        tag: object[index].IlacAd + object[index].tip,
        child: Icon(
          IconData(0xe902, fontFamily: "Ic"),
          color: Color(0xFF3EB16F),
          size: size,
        ),
      );
    } else if (object[index].tip == "Tablet") {
      return Hero(
        tag: object[index].IlacAd + object[index].tip,
        child: Icon(
          IconData(0xe903, fontFamily: "Ic"),
          color: Color(0xFF3EB16F),
          size: size,
        ),
      );
    }
    return Hero(
      tag: object[index].IlacAd + object[index].tip,
      child: Icon(
        Icons.error,
        color: Color(0xFF3EB16F),
        size: size,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchilacData(FirebaseAuth.instance.currentUser!.uid.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IlacEkle>(
      create: (_) => IlacEkle(),
      builder: (context, _) => Scaffold(
        backgroundColor: Color(0xFFF6F8FC),
        // appBar: AppBar(
        //   backgroundColor: Colors.cyan[100],
        //   title: Text('İlaç Takip'),
        //   automaticallyImplyLeading: false,
        //   centerTitle: true,
        // ),
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
                builder: (context) => IlacEkleme(),
              ),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(50, 27),
                    bottomRight: Radius.elliptical(50, 27),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color.fromARGB(255, 146, 143, 183),
                      offset: Offset(0, 3.5),
                    )
                  ],
                  color: Color.fromARGB(255, 243, 238, 245),
                ),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: Text(
                        "İlaç Takip",
                        style: TextStyle(
                          // fontFamily: "Angel",
                          fontSize: 45,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.cyan[100],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Text(
                          "Takip Edilen İlaç Sayısı",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      object.length.toString(),
                      style: TextStyle(
                        fontFamily: "Neu",
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              object.length > 0
                  ? Container(
                      height: object.length * 200,
                      color: Color(0xFFF6F8FC),
                      child: GridView.builder(
                          padding: EdgeInsets.only(top: 12),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: object.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(10.0),
                              child: InkWell(
                                highlightColor: Colors.white,
                                splashColor: Colors.grey,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await context
                                                  .read<IlacEkle>()
                                                  .silIlacAd(
                                                      object[index].IlacAd);
                                              setState(() {
                                                fetchilacData(FirebaseAuth
                                                    .instance.currentUser!.uid
                                                    .toString());
                                              });
                                            },
                                            icon: Icon(Icons.clear),
                                          ),
                                        ],
                                      ),
                                      makeIcon(50.0, index),
                                      Hero(
                                        tag: object[index].IlacAd,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            object[index].IlacAd,
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Color(0xFF3EB16F),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Her " +
                                            object[index].aralik +
                                            " saate",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFFC9C9C9),
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }))
                  : Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Container(
                        color: Color(0xFFF6F8FC),
                        child: const Center(
                          child: Text(
                            "İlaç Eklemek İçin + Butonuna Basınız",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                color: Color(0xFFC9C9C9),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
