// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

//String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.title,
    this.parent,
    this.parentName,
    this.stockCode,
    this.image,
    this.prices,
    //this.children,
  });

  dynamic id;
  String title;
  dynamic parent;
  String parentName;
  String stockCode;
  dynamic ctnPrice;
  String image;
  List<Price> prices;
  //List<int> children;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        parent: json["parent"] == null ? null : json["parent"],
        parentName: json["parent_name"] == null ? null : json["parent_name"],
        stockCode: json["stock_code"] == null ? null : json["stock_code"],
        image: json["image"] == null ? null : json["image"],
        prices: json["prices"] == null
            ? null
            : List<Price>.from(json["prices"].map((x) => Price.fromMap(x))),
        //children: List<int>.from(json["children"].map((x) => x)),
      );

  int get quantity => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "parent": parent == null ? null : parent,
        "parent_name": parentName == null ? null : parentName,
        "stock_code": stockCode,
        "ctn_price": ctnPrice,
        "image": image,
        //"children": List<dynamic>.from(children.map((x) => x)),
      };
}

class Price {
  Price({
    this.id,
    this.unit,
    this.barcode,
    this.price,
    this.product,
  });

  dynamic id;
  String unit;
  String barcode;
  dynamic price;
  dynamic product;

  factory Price.fromMap(Map<String, dynamic> json) => Price(
        id: json["id"],
        unit: json["unit"],
        barcode: json["barcode"],
        price: json["price"],
        product: json["product"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "unit": unit,
        "barcode": barcode,
        "price": price,
        "product": product,
      };
}
