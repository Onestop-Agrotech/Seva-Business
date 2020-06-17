
class AllShops {
  AllShops({
    this.id,
    this.storeId,
    this.username,
    this.mobile,
    this.type,
    this.shopNumber,
    this.city,
    this.state,
    this.coordinates,
    this.date,
    this.v,
  });

  String id;
  String storeId;
  String username;
  int mobile;
  String type;
  int shopNumber;
  String city;
  String state;
  Coordinates coordinates;
  DateTime date;
  int v;

  factory AllShops.fromJson(Map<String, dynamic> json) => AllShops(
        id: json["_id"],
        storeId: json["store_id"],
        username: json["username"],
        mobile: json["mobile"],
        type: json["type"],
        shopNumber: json["shop_number"],
        city: json["city"],
        state: json["state"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "store_id": storeId,
        "username": username,
        "mobile": mobile,
        "type": type,
        "shop_number": shopNumber,
        "city": city,
        "state": state,
        "coordinates": coordinates.toJson(),
        "date": date.toIso8601String(),
        "__v": v,
      };
}

class Coordinates {
  Coordinates({
    this.lat,
    this.long,
  });

  int lat;
  int long;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };
}
//TO ADD A SHOP(NOT USING)
//String allShopsToJson(AllShops data) => json.encode(data.toJson());
