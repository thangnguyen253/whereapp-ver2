class PlaceItemRes {
  String name;
  String address;
  double lat;
  double lng;
  PlaceItemRes(this.name, this.address, this.lat, this.lng);

  static List<PlaceItemRes> fromJson(Map<String, dynamic> json) {
    print("parse data");
    List<PlaceItemRes> rs = [];

    var results = json['features'] as List;
    for (var item in results) {
      var p = new PlaceItemRes(
          item['properties']['name'],
          item['properties']['label'],
          item['geometry']['coordinates'][0],
          item['geometry']['coordinates'][1]);
      rs.add(p);
    }
    return rs;
  }
}
