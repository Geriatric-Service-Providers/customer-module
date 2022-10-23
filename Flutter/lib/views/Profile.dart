import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/views/Login.dart';
import 'package:shopx/views/Logout.dart';
import 'package:shopx/views/MyOrders.dart';
import 'package:shopx/views/globals.dart';

class Profile extends StatelessWidget {

  void logout(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => Mobilenumber(),
        ),
        (route) => false,//if you want to disable back feature set to false
);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              // color: Colors.green[800],
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/profile_bg.png'))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.lightBlue[900],
                    backgroundImage: AssetImage("images/Profile.png"),
                  ),
                  Text(
                    Globals.name.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            RoundedCard(
              cardTap: () => MyOrders(),
              icon: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.green,
              ),
              text: "My Orders",
            ),
            RoundedCard(
              icon: Icon(
                Icons.money,
                color: Colors.green,
              ),
              text: "Reward Points : " + Globals.rewardPoints,
            ),
            RoundedCard(
              // cardTap: () => RemoteServices.removePrefs(),
              cardTap: () => Logout(),
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.green,
              ),
              text: "Logout",
            ),
            RoundedCard(
              icon: Icon(
                Icons.support,
                color: Colors.green,
              ),
              text: "Support",
            ),
          ],
        ),
      
      ),
    );
  }
}

class RoundedCard extends StatelessWidget {
  final Icon icon;
  final String text;
  final Function cardTap;
  RoundedCard({this.icon, this.text, this.cardTap});
  @override
  Widget build(BuildContext context) {
    if (cardTap == null) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        height: 70,
        width: 330,
        
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          child: Row(
            children: [
              Container(margin: EdgeInsets.only(left: 15), child: icon),
              SizedBox(
                width: 15,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  "$text",
                  style: GoogleFonts.openSans(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 70,
      width: 330,
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => cardTap())),
        child: 
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          child: Row(
            children: [
              Container(margin: EdgeInsets.only(left: 15), child: icon),
              SizedBox(
                width: 15,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  "$text",
                  style: GoogleFonts.openSans(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
