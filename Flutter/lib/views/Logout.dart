import 'package:flutter/material.dart';
import 'package:shopx/services/remote_services.dart';
import 'package:shopx/views/Login.dart';

class Logout extends StatelessWidget {

  void checkLogout(context) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('isLoggedIn');
    // await prefs.remove('phone');
    // Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => Mobilenumber()));
    RemoteServices.removePrefs(context);
    Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => Mobilenumber()));
  }

Widget build(BuildContext context) {
checkLogout(context);
return SafeArea(
  child: Scaffold(
    body: SingleChildScrollView(),
    bottomNavigationBar: SizedBox(),
  ),
);
}

}