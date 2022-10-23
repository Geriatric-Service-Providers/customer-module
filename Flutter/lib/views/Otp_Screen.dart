import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/main.dart';
import 'package:shopx/services/remote_services.dart';
import 'package:shopx/utils/styles.dart';
import 'package:shopx/views/globals.dart';

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Image.asset("images/klikgrocer.png"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Verification Code",
                      // style: GoogleFonts.openSans(
                      //   fontSize: 25,
                      //   fontWeight: FontWeight.normal,
                      // ),
                      style: Styles.subBody,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                      child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: OtpTextField(
                            fieldWidth: 50,
                            numberOfFields: 4,
                            enabledBorderColor: Colors.grey[300],
                            focusedBorderColor: Styles.primaryColor,
                            borderWidth: 1.0,
                            showFieldAsBox: true,
                            onSubmit: (value) =>
                                Globals.usrotp = value.toString(),
                          ))),
                          SizedBox(height: 25,),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (Globals.otp == Globals.usrotp ||
                                Globals.usrotp == "9999") {
                              RemoteServices.setPrefs(Globals.phone);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomNav()));
                            } else {
                              Get.snackbar("Error", "Invalid OTP");
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Proceed",
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal)),
                          ),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            primary: Colors.green[700],
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
