import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:shopx/auth/secrets.dart';
import 'package:shopx/views/Login.dart';
import 'package:http/http.dart' as http;
import 'package:shopx/models/factory.dart';
import 'package:shopx/views/homepage.dart';

class RemoteServices {
  static var client = http.Client();

  //  API endpoint for signing up

  static void signUp(
      name, age, email, mobile, address, city, district, password) async {
    final response =
        await client.post(Uri.parse('http://127.0.0.1:8000/registration/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'userType': 'customer',
              'phone': mobile,
              'password': password,
              'name': name,
              'age': age,
              'email': email,
              'address': address,
              'city': city,
              'district': district
            }));

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Signup Successfull");
      Get.to(() => Mobilenumber());
    }
  }

  // Login request endpoint to django 

  static void login(username, password, context) async {
    final response = await client.post(
        Uri.parse('http://127.0.0.1:8000/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
          'loginType': 'customer'
        }));

    if (response.statusCode == 200) {

      // Converting login api response to flutter object

      Login login = Login.fromJson(jsonDecode(response.body));
      access = login.access;
      Get.to(() => HomePage());
      Get.snackbar("Success", "Login SuccessFull");
    } else {
      Get.snackbar("Error", "There was an Error Please Contact Administrator",
          duration: const Duration(seconds: 3));
    }
  }

  // Dashboard view for listing organizations

  static Future<List<dynamic>> fetchOrganization() async {
    var response = await client.get(
      Uri.parse('http://127.0.0.1:8000/dashboard/?page=home'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $access",
      },
    );
    if (response.statusCode == 200) {
      return DashboardfromJson(response.body);
    } else {
      return null;
    }
  }

  // Members detail view for Organization selected

  static Future<List<dynamic>> fetchOrganizationMembers() async {
    var response = await client.get(
      Uri.parse(
          'http://127.0.0.1:8000/dashboard/?page=detail&id=$organizationId'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $access",
      },
    );
    if (response.statusCode == 200) {
      return MemberDetailsfromJson(response.body);
    } else {
      return null;
    }
  }

  // API endpoint for booking appoitments

  static void bookAppointments(date) async {
    final response =
        await client.post(Uri.parse('http://127.0.0.1:8000/book/'),
            headers: <String, String>{
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer $access",
            },
            body: jsonEncode(<String, dynamic>{
              'date': date,
              'organization':organizationId
            }));

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Appointment Booking SuccessFull");
    } else {
      Get.snackbar("Error", "There was an Error Please Contact Administrator",
          duration: const Duration(seconds: 3));
    }
  }
}
