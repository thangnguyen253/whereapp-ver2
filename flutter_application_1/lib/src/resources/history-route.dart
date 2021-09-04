import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wemapgl/wemapgl.dart';

class DirectionAPI extends StatefulWidget {
  final double fromLat;
  final double fromLng;
  final double toLat;
  final double toLng;
  final int type;
  DirectionAPI(this.fromLat, this.fromLng, this.toLat, this.toLng, this.type);

  @override
  State createState() => DirectionAPIState();
}

class DirectionAPIState extends State<DirectionAPI> {
  WeMapDirections directionAPI = WeMapDirections();
  String? typeOfTransport;
  int _tripDistance = 0;
  late WeMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History Detail"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Stack(
        children: <Widget>[
          WeMap(
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: onStyleLoadedCallback,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.fromLat, widget.fromLng),
              zoom: 15.0,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ListTile(
              title: Text(
                  "Distance: ${(_tripDistance / 1000).toStringAsFixed(1)}km"),
              leading: typeOfTransport == "car"
                  ? Icon(CupertinoIcons.car_detailed)
                  : Icon(Icons.motorcycle_sharp),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(WeMapController mapController) {
    this.mapController = mapController;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onStyleLoadedCallback() async {
    List<LatLng> points = [];

    points.add(LatLng(widget.fromLat, widget.fromLng)); //origin Point
    points.add(LatLng(widget.toLat, widget.toLng)); //destination Point

    final json = await directionAPI.getResponseMultiRoute(
        widget.type, points); //0 = car, 1 = bike, 2 = foot
    List<LatLng> _route = directionAPI.getRoute(json);
    List<LatLng> _waypoins = directionAPI.getWayPoints(json);
    if (widget.type == 0) {
      typeOfTransport = "car";
    } else {
      typeOfTransport = "bike";
    }
    setState(() {
      _tripDistance = directionAPI.getDistance(json);
    });

    await mapController.addLine(
      LineOptions(
        geometry: _route,
        lineColor: "#0071bc",
        lineWidth: 5.0,
        lineOpacity: 1,
      ),
    );
    await mapController.addCircle(CircleOptions(
        geometry: _waypoins[0],
        circleRadius: 8.0,
        circleColor: '#d3d3d3',
        circleStrokeWidth: 1.5,
        circleStrokeColor: '#0071bc'));
    for (int i = 1; i < _waypoins.length; i++) {
      await mapController.addCircle(CircleOptions(
          geometry: _waypoins[i],
          circleRadius: 8.0,
          circleColor: '#ffffff',
          circleStrokeWidth: 1.5,
          circleStrokeColor: '#0071bc'));
    }
  }
}
