import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard({required this.text, required this.icon, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.cyan[100],
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.blueGrey[200],
              fontSize: 20.0,
              fontFamily: 'Source Sans Pro',
            ),
          ),
        ),
      ),
    );
  }
}
