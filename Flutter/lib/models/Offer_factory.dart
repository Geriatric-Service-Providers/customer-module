// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

import 'dart:convert';

List<Banners> bannerFromJson(String str) =>
    List<Banners>.from(json.decode(str).map((x) => Banners.fromJson(x)));

String bannerToJson(List<Banners> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Banners {
  Banners({
    this.image,
    this.productIds,
  });

  String image;
  List<int> productIds;

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
        image: json["image"],
        productIds: List<int>.from(json["product_ids"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "product_ids": List<dynamic>.from(productIds.map((x) => x)),
      };
}
