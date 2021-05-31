import 'dart:async';

import 'package:flutter_application_1/src/repository/place_service.dart';

class SearchBloc {
  var _placeController = StreamController();
  Stream get placeStream => _placeController.stream;

  void searchPlace(String keyword) {
    print("place bloc search: " + keyword);
    _placeController.sink.add("start");
    PlaceService.searchPlace(keyword).then((rs) {
      _placeController.sink.add(rs);
    }).catchError(() {});
  }

  void dispose() {
    _placeController.close();
  }
}
