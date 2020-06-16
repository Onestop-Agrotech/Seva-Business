class AllShops {
  bool response;
  List<Output> output;

  AllShops({this.response, this.output});

  AllShops.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    if (json['output'] != null) {
      output = new List<Output>();
      json['output'].forEach((v) {
        output.add(new Output.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    if (this.output != null) {
      data['output'] = this.output.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Output {
  String sId;
  String storeId;
  String username;
  int mobile;
  String type;
  int shopNumber;
  String city;
  String state;
  Coordinates coordinates;
  String date;
  int iV;

  Output(
      {this.sId,
      this.storeId,
      this.username,
      this.mobile,
      this.type,
      this.shopNumber,
      this.city,
      this.state,
      this.coordinates,
      this.date,
      this.iV});

  Output.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    storeId = json['store_id'];
    username = json['username'];
    mobile = json['mobile'];
    type = json['type'];
    shopNumber = json['shop_number'];
    city = json['city'];
    state = json['state'];
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['store_id'] = this.storeId;
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    data['type'] = this.type;
    data['shop_number'] = this.shopNumber;
    data['city'] = this.city;
    data['state'] = this.state;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}

class Coordinates {
  int lat;
  int long;

  Coordinates({this.lat, this.long});

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
