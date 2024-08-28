// import 'dart:html';

//import 'dart:ffi';
//import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:flutter/semantics.dart';
//import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:saglik_asistani/HastalikBilgiEkrani.dart';
import 'package:saglik_asistani/IlacEklemeModel.dart';
import 'package:saglik_asistani/IlacTakipEkrani.dart';
import 'package:saglik_asistani/animasyon.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class IlacEkleme extends StatefulWidget {
  @override
  State<IlacEkleme> createState() => _IlacEklemeState();
}

class _IlacEklemeState extends State<IlacEkleme> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _AdKonrol = TextEditingController();
  TextEditingController _DozKontrol = TextEditingController();
  late String tip;
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String kullanici_id = FirebaseAuth.instance.currentUser?.uid ?? '';
  bool _Tiklandimi = false;
  bool _Tiklandimi1 = false;
  bool _Tiklandimi2 = false;
  bool _Tiklandimi3 = false;
  late String ilacismi;
  late int Doz;
  var sayi = 0;
  var secenek = [6, 8, 12, 24];
  var sec = 0;
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        // _newEntryBloc.updateTime("${convertTime(_time.hour.toString())}" +
        //    "${convertTime(_time.minute.toString())}");
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IlacEkle>(
      create: (_) => IlacEkle(),
      builder: (context, _) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.cyan[100],
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Yeni İlaç Ekle",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HastalikBilgiEkrani())); // Geri butonuna basıldığında önceki sayfaya geçiş yapılır
            },
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
                  child: TextFormField(
                    controller: _AdKonrol,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      labelText: "İlaç Adı",
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      //border: OutlineInputBorder(),
                    ),
                    cursorColor: Colors.cyan,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: _DozKontrol,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.cyan,
                        ),
                      ),

                      labelText: "İlaç Dozu",
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      // border: OutlineInputBorder(),
                    ),
                    cursorColor: Colors.cyan,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "İlaç Tipi",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _Tiklandimi = true;
                          _Tiklandimi1 = false;
                          _Tiklandimi2 = false;
                          _Tiklandimi3 = false;
                          tip = "Şurup";
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  _Tiklandimi ? Colors.cyan[100] : Colors.white,
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0),
                                child: Icon(
                                  IconData(0xe900, fontFamily: "Ic"),
                                  size: 95,
                                  color: _Tiklandimi
                                      ? Colors.white
                                      : Colors.cyan[100],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                color: _Tiklandimi
                                    ? Colors.cyan[100]
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "Şurup",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _Tiklandimi
                                        ? Colors.white
                                        : Colors.cyan[100],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _Tiklandimi = false;
                          _Tiklandimi1 = true;
                          _Tiklandimi2 = false;
                          _Tiklandimi3 = false;
                          tip = "Hap";
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _Tiklandimi1
                                  ? Colors.cyan[100]
                                  : Colors.white,
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0),
                                child: Icon(
                                  IconData(0xe901, fontFamily: "Ic"),
                                  size: 95,
                                  color: _Tiklandimi1
                                      ? Colors.white
                                      : Colors.cyan[100],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                color: _Tiklandimi1
                                    ? Colors.cyan[100]
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "Hap",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _Tiklandimi1
                                        ? Colors.white
                                        : Colors.cyan[100],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _Tiklandimi = false;
                          _Tiklandimi1 = false;
                          _Tiklandimi2 = true;
                          _Tiklandimi3 = false;
                          tip = "Şırınga";
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _Tiklandimi2
                                  ? Colors.cyan[100]
                                  : Colors.white,
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0),
                                child: Icon(
                                  IconData(0xe902, fontFamily: "Ic"),
                                  size: 95,
                                  color: _Tiklandimi2
                                      ? Colors.white
                                      : Colors.cyan[100],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                color: _Tiklandimi2
                                    ? Colors.cyan[100]
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "Şırınga",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _Tiklandimi2
                                        ? Colors.white
                                        : Colors.cyan[100],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _Tiklandimi = false;
                          _Tiklandimi1 = false;
                          _Tiklandimi2 = false;
                          _Tiklandimi3 = true;
                          tip = "Tablet";
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _Tiklandimi3
                                  ? Colors.cyan[100]
                                  : Colors.white,
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0),
                                child: Icon(
                                  IconData(0xe903, fontFamily: "Ic"),
                                  size: 95,
                                  color: _Tiklandimi3
                                      ? Colors.white
                                      : Colors.cyan[100],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                color: _Tiklandimi3
                                    ? Colors.cyan[100]
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "Tablet",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _Tiklandimi3
                                        ? Colors.white
                                        : Colors.cyan[100],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Aralık Seçimi",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Bana her  ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      DropdownButton<int>(
                        iconEnabledColor: Colors.cyan[100],
                        hint: sec == 0
                            ? Text(
                                "Saat seç",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              )
                            : null,
                        elevation: 4,
                        value: sec == 0 ? null : sec,
                        items: secenek.map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(
                              value.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            sec = newVal!;
                          });
                        },
                      ),
                      Text(
                        sec == 1 ? " saatte hatırlat" : " saatte hatırlat",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 4),
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.cyan[100])),
                      //color: Color(0xFF3EB16F),
                      //shape: StadiumBorder(),
                      onPressed: () {
                        _selectTime(context);
                      },
                      child: Center(
                        child: Text(
                          _clicked == false
                              ? "Saat seçiniz"
                              : "${convertTime(_time.hour.toString())}:${convertTime(
                                  _time.minute.toString(),
                                )}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 220,
                  height: 70,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.cyan[100])),
                    child: Center(
                      child: Text(
                        "Ekle",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_AdKonrol.text == "") {
                        hata("Lütfen ilacın adını giriniz");
                        sayi++;
                      }
                      if (_AdKonrol.text != "") {
                        ilacismi = _AdKonrol.text;
                      }
                      if (_DozKontrol.text == "") {
                        Doz = 0;
                      }
                      if (_DozKontrol.text != "") {
                        Doz = int.parse(_DozKontrol.text);
                      }
                      // for (var medicine in _globalBloc.medicineList$.value) {
                      //   if (ilacismi == medicine.medici
                      //   ) {
                      //     _newEntryBloc.submitError(EntryError.NameDuplicate);ss
                      //     return;
                      //   }
                      // }
                      if (sec == 0) {
                        hata("Lütfen hatırlatmanın aralığını seçin");
                        sayi++;
                      }
                      if (_time.hour == 0 && _time.minute == 00) {
                        hata("Lütfen hatırlatıcının başlangıç ​​saatini seçin");
                        sayi++;
                      }
                      //scheduleNotification();

                      if (sayi == 0) {
                        if (kDebugMode) {
                          print("cjvcjxkvjkdxjdjfdj");
                        }
                        context.read<IlacEkle>().ekleIlac(
                              Kid: kullanici_id,
                              ilacad: ilacismi.toString(),
                              doz: Doz.toString(),
                              tip: tip.toString(),
                              aralik: sec.toString(),
                              saat: _time.hour.toString(),
                              dakika: _time.minute.toString(),
                            );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Animasyon();
                            },
                          ),
                        );
                      }
                      sayi = 0;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void hata(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(
            width: 30,
          ),
          Text(error),
        ],
      ),
      duration: Duration(seconds: 1),
    ));
  }

  String convertTime(String hour) {
    int parsedHour = int.parse(hour);
    if (parsedHour < 10) {
      return '0$hour';
    } else {
      return hour;
    }
  }

  // Future onSelectNotification() async {
  //   if (payload != null) {
  //     debugPrint('notification payload: ' + payload);
  //   }
  //   await Navigator.push(
  //     context,
  //     new MaterialPageRoute(builder: (context) => HomePage()),
  //   );
  // }

  // initializeNotifications() async {
  //   var initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/launcher_icon');
  //   // var initializationSettingsIOS = IOSInitializationSettings();
  //   var initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //   );
  //   await flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //   );
  // }

  // Future<void> scheduleNotification() async {
  //   var hour = _time.hour;
  //   var ogValue = hour;
  //   var minute = _time.minute;

  //   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
  //     'repeatDailyAtTime channel id',
  //     'repeatDailyAtTime channel name',
  //     'repeatDailyAtTime description',
  //     importance: Importance.max,
  //     sound: RawResourceAndroidNotificationSound('default'),
  //     ledColor: Color(0xFF3EB16F),
  //     ledOffMs: 1000,
  //     ledOnMs: 1000,
  //     enableLights: true,
  //   );
  //   // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //   );

  //   for (int i = 0; i < (24 / sec).floor(); i++) {
  //     if ((hour + (sec * i) > 23)) {
  //       hour = hour + (sec * i) - 24;
  //     } else {
  //       hour = hour + (sec * i);
  //     }

  //     await flutterLocalNotificationsPlugin.showDailyAtTime(
  //         0,
  //         'İlaç: ${ilacismi}',
  //         'It is time to take your ${tip.toLowerCase()}, according to schedule',
  //         Time(
  //           0,
  //           hour,
  //           minute,
  //         ),
  //         platformChannelSpecifics);
  //     hour = ogValue;
  //   }
  //   //await flutterLocalNotificationsPlugin.cancelAll();
  // }
}
