import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/utils/styles.dart';
import 'package:shopx/views/SignUp.dart';
import 'package:shopx/services/remote_services.dart';

// Login UI

class Mobilenumber extends StatelessWidget {

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                  width: double.infinity,
                  child: Image.asset('images/logo.png')),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: TextFormField(
                        style: Styles.generalBody,
                        keyboardType: TextInputType.number,
                        controller: userNameController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "Username",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                      ),
                    ),
                    Container(
                      height: 50,
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: TextFormField(
                        obscureText: true,
                        style: Styles.generalBody,
                        keyboardType: TextInputType.number,
                        controller: passwordController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (userNameController.text.length != 0 &&
                              passwordController.text.length != 0) {
                            RemoteServices.login(userNameController.text,
                                passwordController.text, context);
                          } else if (userNameController.text.length == 0) {
                            Get.snackbar("Failed", "Please Enter your Email");
                          } else if (passwordController.text.length == 0) {
                            Get.snackbar(
                                "Failed", "Please Enter Your Password");
                          }
                          // Globals.phone = phoneController.text;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Login",
                              style: GoogleFonts.openSans(
                                  fontSize: 16, fontWeight: FontWeight.normal)),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Styles.primaryColor,
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // padding: EdgeInsets.symmetric(
                          //     horizontal: 50.0, vertical: 10.0)
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New user?",
                          style: Styles.generalBody,
                        ),
                        TextButton(
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Signup())),
                            child:
                                Text("Sign Up", style: Styles.primaryTextBody)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
