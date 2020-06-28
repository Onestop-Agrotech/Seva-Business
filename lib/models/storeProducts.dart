import 'dart:convert';

List<StoreProduct> fromJsonToStoreProduct(String str) =>
    List<StoreProduct>.from(
        json.decode(str).map((x) => StoreProduct.fromJson(x)));

String fromStoreProductToJson(List<StoreProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreProduct {
  StoreProduct({
    this.quantity,
    this.id,
    this.name,
    this.type,
    this.uniqueId,
    this.description,
    this.price,
    this.pictureUrl,
    this.outOfStock,
  });

  Quantity quantity;
  String id;
  String name;
  String type;
  String uniqueId;
  String description;
  int price;
  String pictureUrl;
  bool outOfStock;

  factory StoreProduct.fromJson(Map<String, dynamic> json) => StoreProduct(
        quantity: Quantity.fromJson(json["quantity"]),
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        uniqueId: json["uniqueId"],
        description: json["description"],
        price: json["price"],
        pictureUrl: json["pictureURL"],
        outOfStock: json["outOfStock"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity.toJson(),
        "_id": id,
        "name": name,
        "type": type,
        "uniqueId": uniqueId,
        "description": description,
        "price": price,
        "pictureURL": pictureUrl,
        "outOfStock": outOfStock,
      };
}

class Quantity {
  Quantity({
    this.quantityValue,
    this.quantityMetric,
  });

  int quantityValue;
  String quantityMetric;

  factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
        quantityValue: json["quantityValue"],
        quantityMetric: json["quantityMetric"],
      );

  Map<String, dynamic> toJson() => {
        "quantityValue": quantityValue,
        "quantityMetric": quantityMetric,
      };
}
