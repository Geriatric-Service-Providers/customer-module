// To parse this JSON data, do
//
//     final items = itemsFromMap(jsonString);

import 'dart:convert';

List<Items> cartFromJson(String str) =>
    List<Items>.from(json.decode(str).map((x) => Items.fromMap(x)));

// String itemsToMap(List<Items> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Items {
  Items({
    this.id,
    this.prodId,
    this.product,
    this.priceId,
    this.unit,
    this.price,
    this.quantity,
    this.total,
    this.availableUnits,
  });

  dynamic id;
  dynamic prodId;
  String product;
  dynamic priceId;
  String unit;
  dynamic price;
  dynamic quantity;
  dynamic total;
  List<AvailableUnit> availableUnits;

  factory Items.fromMap(Map<String, dynamic> json) => Items(
        id: json["id"],
        prodId: json["prod_id"],
        product: json["product"],
        priceId: json["price_id"],
        unit: json["unit"],
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
        availableUnits: List<AvailableUnit>.from(
            json["available_units"].map((x) => AvailableUnit.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "prod_id": prodId,
        "product": product,
        "price_id": priceId,
        "unit": unit,
        "price": price,
        "quantity": quantity,
        "total": total,
        "available_units":
            List<dynamic>.from(availableUnits.map((x) => x.toMap())),
      };
}

class AvailableUnit {
  AvailableUnit({
    this.unit,
    this.barcode,
    this.price,
  });

  String unit;
  String barcode;
  dynamic price;

  factory AvailableUnit.fromMap(Map<String, dynamic> json) => AvailableUnit(
        unit: json["unit"],
        barcode: json["barcode"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "unit": unit,
        "barcode": barcode,
        "price": price,
      };
}
