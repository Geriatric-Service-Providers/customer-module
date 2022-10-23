// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Orders> ordersFromJson(String str) =>
    List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

List<Products> prevProdFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

// String categoryToJson(List<Category> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  dynamic id;
  dynamic pageCount;
  String name;
  String phone;
  String email;
  String area;
  String building;
  List<Products> products;
  String dateAdded;
  String landmark;
  String paymentMethod;
  dynamic total;
  String date;
  String status;

  Orders(
      {this.id,
      this.pageCount,
      this.name,
      this.phone,
      this.email,
      this.area,
      this.building,
      this.products,
      this.dateAdded,
      this.landmark,
      this.paymentMethod,
      this.total,
      this.date,
      this.status});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageCount = json['page_count'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    area = json['area'];
    building = json['building'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    dateAdded = json['date_added'];
    landmark = json['landmark'];
    paymentMethod = json['payment_method'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['page_count'] = this.pageCount;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['area'] = this.area;
    data['building'] = this.building;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['date_added'] = this.dateAdded;
    data['landmark'] = this.landmark;
    data['payment_method'] = this.paymentMethod;
    data['total'] = this.total;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}

class Products {
  dynamic id;
  String title;
  dynamic price;
  dynamic total;
  dynamic quantity;

  Products({this.id, this.title, this.price, this.total, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    total = json['total'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['total'] = this.total;
    data['quantity'] = this.quantity;
    return data;
  }
}
