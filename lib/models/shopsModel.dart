class ShopsModel {
  ShopsModel({
    this.id,
    this.storeId,
    this.username,
    this.mobile,
    this.type,
    this.shopNumber,
    this.city,
    this.state,
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
  DateTime date;
  int v;

  factory ShopsModel.fromJson(Map<String, dynamic> json) => ShopsModel(
        id: json["_id"],
        storeId: json["store_id"],
        username: json["username"],
        mobile: json["mobile"],
        type: json["type"],
        shopNumber: json["shop_number"],
        city: json["city"],
        state: json["state"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );
}
