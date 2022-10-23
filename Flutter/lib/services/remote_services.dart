import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/controllers/controllers.dart';
import 'package:shopx/main.dart';
import 'package:shopx/models/Offer_factory.dart';
import 'package:shopx/views/Checkoutpage.dart';
import 'package:shopx/views/Login.dart';
import 'package:shopx/views/Otp_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:shopx/models/product_factory.dart';
import 'package:shopx/models/cart_factory.dart';
import 'package:shopx/models/orders_factory.dart';
import 'package:shopx/views/globals.dart';
import 'dart:math';

import 'package:shopx/views/homepage.dart';

class RemoteServices {
  static var client = http.Client();
  static void signUp(name, age, email, mobile, username, password) async {
    final response =
        await http.post(Uri.parse('http://127.0.0.1:8000/registration/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'name': name,
              'age': age,
              'email': email,
              'mobile': mobile,
              'username': username,
              'password': password,
            }));

    if (response.statusCode == 200) {
      Get.snackbar("Signup Success", "Please wait for Confirmation");
      Get.to(() => Mobilenumber());
    }
  }

  static void setPrefs(dynamic phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('phone', phone);
  }

  static void removePrefs(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('phone');

    // Navigator.pushReplacement(
    //           context, MaterialPageRoute(builder: (context) => Mobilenumber()));
    // Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => Mobilenumber()));
    Get.to(() => Mobilenumber());
  }

  static void fetchToken(username, password, context) async {
    final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{'username': username, 'password': password}));

    if (response.statusCode == 200) {
      Get.to(() => Palliative());
      Get.snackbar("Success", "Login SuccessFull");
    } else {
      Get.snackbar("Error", "There was an Error Please Contact Administrator",
          duration: const Duration(seconds: 3));
    }
  }

  static Future<List<Banners>> fetchBanner() async {
    var response =
        await client.get(Uri.parse('https://arunlaxman.com/mobile/banners/'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return bannerFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<Category>> fetchBannerProducts() async {
    var jsonString = "[";
    for (int i = 0; i < Globals.primary.length; i++) {
      var id = Globals.primary[i];
      var response = await client
          .get(Uri.parse('https://arunlaxman.com/mobile/products-nest/$id/'));
      if (response.statusCode == 200) {
        jsonString = jsonString + response.body + ",";
      }
    }
    jsonString = jsonString.substring(0, jsonString.length - 1);
    jsonString = jsonString + "]";
    return categoryFromJson(jsonString);
  }

  static Future<List<Orders>> fetchPrevOrders() async {
    String token = Globals.token;
    final response = await http.get(
      Uri.parse('https://arunlaxman.com/mobile_order'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      return ordersFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<List<Category>> fetchCategories() async {
    var response = await client
        .get(Uri.parse('https://arunlaxman.com/mobile/categories/'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return categoryFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<Category>> fetchSubCategories(id) async {
    var response = await client
        .get(Uri.parse('https://arunlaxman.com/mobile/categories/$id/'));
    if (response.statusCode == 200) {
      var jsonString = response.body.substring(
          (response.body.indexOf('"children"')) + 11, response.body.length - 1);
      return categoryFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<Category>> fetchProducts(id) async {
    var response = await client.get(Uri.parse(
        'https://arunlaxman.com/mobile/products/?category=$id&offset=0&limit=1000'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return categoryFromJson(jsonString);
    } else {
      return null;
    }
  }

  static void addToCart(id, qty, priceId) async {
    dynamic token = Globals.token;
    final response =
        await http.post(Uri.parse('https://arunlaxman.com/mobile/cart'),
            headers: <String, String>{
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer $token"
            },
            body: jsonEncode(<dynamic, dynamic>{
              'product_id': id,
              "quantity": qty,
              "price_id": priceId,
            }));

    if (response.statusCode == 200) {
      return Get.snackbar("Success", "Item added to Cart.");
    } else {
      return Get.snackbar("Failed", "Issue in adding to cart");
    }
  }

  static void deleteCartProduct(id, priceId) async {
    final CartController cartController = Get.put(CartController());
    dynamic token = Globals.token;
    final response =
        await http.delete(Uri.parse('https://arunlaxman.com/mobile/cart'),
            headers: {
              HttpHeaders.authorizationHeader: "Bearer $token",
            },
            body: jsonEncode(<dynamic, dynamic>{
              "product_id": id,
              "price_id": priceId,
            }));
    if (response.statusCode == 200) {
      cartController.fetchCartProducts();
      return Get.snackbar("Success", "Item removed from Cart.");
    } else {
      return Get.snackbar("Failed", "Issue in removing from cart");
    }
  }

  static Future<List<Items>> fetchCartProducts() async {
    final Controller total = Get.put(Controller());
    dynamic token = Globals.token;

    final response = await http.get(
      Uri.parse('https://arunlaxman.com/mobile/cart'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      Globals.cart = "'" + jsonString.substring(1, jsonString.length - 1) + "'";
      try {
        Globals.cartotal = response.body.substring(
            (response.body.indexOf('"total":')) + 8,
            (response.body.indexOf(',"available_units"')));
      } catch (e) {
        Globals.cartotal = "0";
      }
      total.getVal();
      return cartFromJson(jsonString);
    } else {
      return null;
    }
  }

  static void updateCartProduct(id, qty, priceId) async {
    dynamic token = Globals.token;
    final response =
        await http.patch(Uri.parse('https://arunlaxman.com/mobile/cart'),
            headers: {
              HttpHeaders.authorizationHeader: "Bearer $token",
            },
            body: jsonEncode(<dynamic, dynamic>{
              "product_id": id,
              "quantity": qty,
              "price_id": priceId,
            }));
    if (response.statusCode == 200) {
    } else {
      return null;
    }
  }

  static void placeOrder() async {
    final CartController cartController = Get.put(CartController());
    dynamic token = Globals.token;
    final response = await http.post(
      Uri.parse('https://arunlaxman.com/mobile_order'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      Globals.orderDate = new DateTime.now().toString().substring(0, 10);
      Globals.orderId = response.body.substring(
          response.body.indexOf('"id":') + 5,
          response.body.indexOf("total") - 2);
      Get.to(OrderSummary());
      cartController.fetchCartProducts();
      return Get.snackbar("Success", "Your Order has Been Placed");
    } else {
      return Get.snackbar("Failed", "Issue in placing the Order");
    }
  }

  static Future<List<Category>> fetchSearchProducts() async {
    Globals.searchActive = "true";
    var searchText = Globals.searchText;
    var response = await client.get(Uri.parse(
        ''));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return categoryFromJson(jsonString);
    } else {
      return null;
    }
  }
}
