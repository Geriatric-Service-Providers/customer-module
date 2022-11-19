import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/services/remote_services.dart';
// import 'package:shopx/services/remote_services.dart';

// Signup UI

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: [
            Center(
              child: Card(
                elevation: 0,
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "Mobile Number",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "Name",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: ageController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "Age",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "Address",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: cityController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "City",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: districtController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "District",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if (nameController.text.length == 0 ||
                                  mobileController.text.length == 0) {
                                Get.snackbar(
                                    "Error", "Please Fill in the details");
                              } else {
                                RemoteServices.signUp(
                                  nameController.text,
                                  ageController.text,
                                  emailController.text,
                                  mobileController.text,
                                  addressController.text,
                                  cityController.text,
                                  districtController.text,
                                  passwordController.text,
                                );
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
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green[700],
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              // padding: EdgeInsets.symmetric(

                              //     horizontal: 50.0, vertical: 10.0)
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
