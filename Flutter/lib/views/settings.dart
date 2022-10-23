import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: ElevatedButton(
          onPressed: () {},
          child: Text("Log Out"),
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Colors.green[700],
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0)),
        ),
      ),
    ));
  }
}
