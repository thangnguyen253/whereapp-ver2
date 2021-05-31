import 'dart:convert';
import 'dart:async';
import 'package:flutter_application_1/src/model/place_item_res.dart';
import 'package:http/http.dart' as http;

class PlaceService {
  static Future<List<PlaceItemRes>> searchPlace(String keyword) async {
    String url = "https://apis.wemap.asia/geocode-1/search?text=" +
        keyword +
        "&key=GqfwrZUEfxbwbnQUhtBMFivEysYIxelQ";
    print("search >>: " + url);
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return PlaceItemRes.fromJson(json.decode(res.body));
    } else {
      return [];
    }
  }
}
