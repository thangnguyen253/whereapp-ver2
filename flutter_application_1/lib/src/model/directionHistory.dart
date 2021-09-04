import 'package:wemapgl/wemapgl.dart';

class DirectionHistory {
  String from;
  String to;
  double price;
  double fromLat;
  double fromLng;
  double toLat;
  double toLng;
  int type;
  DirectionHistory(this.from, this.to, this.price, this.fromLat, this.fromLng,
      this.toLat, this.toLng, this.type);
}
