import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:saglik_asistani/HastalikBilgiEkrani.dart';
import 'package:saglik_asistani/model/HastalikBilgi.dart';

class Hastalik2 extends StatefulWidget {
  Hastalik object;

  Hastalik2(
    this.object,
  );

  @override
  State<Hastalik2> createState() => _Hastalik2State(object);
}

class _Hastalik2State extends State<Hastalik2> with TickerProviderStateMixin {
  Hastalik object;

  _Hastalik2State(
    this.object,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        title: Text(object.hastalik_ad ?? ''),
        leading: IconButton(
            onPressed: () {
              Get.to(HastalikBilgiEkrani());
            },
            icon: Icon(Icons.arrow_back)),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.97,
                height: MediaQuery.of(context).size.height * 0.26,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    // side: BorderSide()
                  ),
                  color: Colors.white,
                  elevation: 20,
                  child: Column(
                    children: [
                      SizedBox(height: 10), // default verilecek
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.23,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      width: MediaQuery.of(context).size.width *
                                          0.46,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: CircleAvatar(
                                        child: Image.asset(object.gorsel ?? ''),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  object.hastalik_ad.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Katagori: " + object.katagori.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                // puan gelicek
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Poliklinik: " + object.poliklinik.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                // puan gelicek
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
                thickness: 3,
                color: Colors.cyan[100],
                endIndent: MediaQuery.of(context).size.width * 0.22,
                indent: MediaQuery.of(context).size.width * 0.22),
            Container(
              child: Text(
                "Hastalık Bilgi",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Divider(
                thickness: 3,
                color: Colors.cyan[100],
                endIndent: MediaQuery.of(context).size.width * 0.22,
                indent: MediaQuery.of(context).size.width * 0.22),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.cyan[50],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(object.hastalik_bilgi.toString()),
              ),
            ),
            Divider(
                thickness: 3,
                color: Colors.cyan[100],
                endIndent: MediaQuery.of(context).size.width * 0.22,
                indent: MediaQuery.of(context).size.width * 0.22),
            Container(
              child: Text(
                "Hastalık Belirtileri",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Divider(
                thickness: 3,
                color: Colors.cyan[100],
                endIndent: MediaQuery.of(context).size.width * 0.22,
                indent: MediaQuery.of(context).size.width * 0.22),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.cyan[50],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(object.belirtileri.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
