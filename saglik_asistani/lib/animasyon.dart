import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:saglik_asistani/IlacEkleme.dart';
//import 'package:medicine_reminder/src/ui/homepage/homepage.dart';

class Animasyon extends StatefulWidget {
  @override
  _AnimasyonState createState() => _AnimasyonState();
}

class _AnimasyonState extends State<Animasyon> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 2200),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IlacEkleme()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Container(
          child: Center(
            child: FlareActor(
              "assets/icon/Success Check.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: "Untitled",
            ),
          ),
        ),
      ),
    );
  }
}
