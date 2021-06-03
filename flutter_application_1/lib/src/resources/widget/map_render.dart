import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wemapgl/wemapgl.dart';

class MapRender extends StatefulWidget {
  @override
  _MapRenderState createState() => _MapRenderState();
}

class _MapRenderState extends State<MapRender> {
  //stream
  WeMapStream<bool> visibleStream = WeMapStream<bool>();
  WeMapStream<int> timeStream = WeMapStream<int>();
  WeMapStream<int> distanceStream = WeMapStream<int>();
  WeMapStream<List<InstructionRoute>> insRouteStream =
      WeMapStream<List<InstructionRoute>>();
  WeMapStream<int> indexStream = WeMapStream<int>();
  WeMapStream<List<LatLng>> routeStream = WeMapStream<List<LatLng>>();
  WeMapStream<List<LatLng>> routePreviewStream = WeMapStream<List<LatLng>>();
  WeMapStream<WeMapPlace> originPlaceStream = WeMapStream<WeMapPlace>();
  WeMapStream<WeMapPlace> destinationPlaceStream = WeMapStream<WeMapPlace>();
  WeMapStream<bool> isDrivingStream = WeMapStream<bool>();
  WeMapStream<bool> fromHomeStream = WeMapStream<bool>();
  int time = 0;
  int tripDistance = 0;
  int tripTime = 0;
  double price = 0;
//Direction
  WeMapDirections directionsAPI = WeMapDirections();
  WeMapSearch? search;
  WeMapController? mapController;
  var mapKey = GlobalKey();
  GlobalKey<ChooseLocationState> _chooseKey = GlobalKey();
  //LatLng? myLatLng;
  Color primaryColor = Color.fromRGBO(0, 113, 188, 1);
  Color primaryColorTransparent = Color.fromRGBO(0, 113, 188, 0);
  int indexOfTab = 0;
  List<LatLng> _route = [];
  List<LatLng> rootPreview = [];
  List<InstructionRoute> insRoute = [];
  bool isController = false;
  bool visible = false;
  bool isYour = true;
  //bool myLatLngEnabled = true;
  String? placeName;
  double? paddingBottom;
  String? from;
  String? to;
  WeMapPlace? _originPlace;
  WeMapPlace? _destinationPlace;

  void _onMapCreated(WeMapController controller) async {
    mapController = controller;
  }

  void onSelected() async {
    if ((_originPlace == null &&
            _chooseKey.currentState != null &&
            _chooseKey.currentState!.ori != null) ||
        (_originPlace != null && _chooseKey.currentState!.ori != null)) {
      _originPlace = WeMapPlace(
          location: _chooseKey.currentState!.ori,
          description: _chooseKey.currentState!.location1);
      originPlaceStream.increment(_originPlace);
      _originPlace!.location = _chooseKey.currentState!.ori;
    }

    if ((_destinationPlace == null &&
            _chooseKey.currentState != null &&
            _chooseKey.currentState!.des != null) ||
        (_destinationPlace != null && _chooseKey.currentState!.des != null)) {
      _destinationPlace = WeMapPlace(
          location: _chooseKey.currentState!.des,
          description: _chooseKey.currentState!.location2);
      destinationPlaceStream.increment(_destinationPlace);
      _destinationPlace!.location = _chooseKey.currentState!.des;
    }

    if (_originPlace != null && _destinationPlace == null) {
      await mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_originPlace!.location!, 18.0));
      mapController?.clearSymbols();
      mapController?.clearCircles();
      await WeMapDirections()
          .addCircle(_originPlace!.location!, mapController, '#d3d3d3');
//      await WeMapDirections().addMarker(widget.originPlace.location, mapController, widget.originIcon);
//      myLatLngEnabled = false;
    }

    if (_originPlace == null && _destinationPlace != null) {
      await mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_destinationPlace!.location!, 18.0));
      mapController?.clearSymbols();
      mapController?.clearCircles();
      await WeMapDirections().addMarker(_destinationPlace!.location,
          mapController, "/flutter_application_1/assets/destination.png");
//      myLatLngEnabled = false;
    }

    if (_originPlace != null && _destinationPlace != null) {
      from =
          '${_originPlace!.location!.latitude},${_originPlace!.location!.longitude}';
      to =
          '${_destinationPlace!.location!.latitude},${_destinationPlace!.location!.longitude}';
      LatLngBounds bounds = WeMapDirections()
          .routeBounds(_originPlace!.location!, _destinationPlace!.location!);
      await WeMapDirections().animatedCamera(mapController, bounds);
      mapController?.clearLines();
      mapController?.clearCircles();
//      await WeMapDirections().addMarker(widget.originPlace.location, mapController, widget.originIcon);
      await WeMapDirections().loadRoute(mapController!, _route, insRoute,
          rootPreview, visible, indexOfTab, from!, to!);
      mapController?.clearSymbols();
      await WeMapDirections().addMarker(_destinationPlace!.location,
          mapController, "/flutter_application_1/assets/destination.png");
//      myLatLngEnabled = false;
    }
  }

  @override
  void initState() {
    super.initState();
    timeStream.increment(0);
    distanceStream.increment(0);
    insRouteStream.increment(insRoute);
    indexStream.increment(0);
    _originPlace = _originPlace;
    _destinationPlace = _destinationPlace;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          WeMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                const CameraPosition(target: LatLng(21.03, 105.78), zoom: 15.0),
            onStyleLoadedCallback: onSelected,
            //myLocationEnabled: myLatLngEnabled,
            compassEnabled: true,
            compassViewMargins: Point(24, 550),
            onMapClick: (point, latlng, place) async {},
          ),
          Positioned(
            key: mapKey,
            height: 156 + MediaQuery.of(context).padding.top,
            left: 0,
            top: 50,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 5, left: 0, right: 0, bottom: 0),
                        child: IconButton(
                          onPressed: () async {
                            print(_originPlace?.toMap());
                            _chooseKey.currentState!.locationSwap(
                                _originPlace!, _destinationPlace!);
                          },
                          icon: Icon(Icons.swap_vert, color: Colors.black),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 0),
                        width: 300,
                        child: Expanded(
                          flex: 12,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 0, left: 0, right: 0, bottom: 0),
                              child: ChooseLocation(
                                //searchLocation: myLatLng,
                                originPlace: _originPlace,
                                destinationPlace: _destinationPlace,
                                //originIcon: widget.originIcon,
                                //destinationIcon: widget.destinationIcon,
                                onSelectOriginPlace: (place) =>
                                    setState(() => _originPlace = place),
                                onSelectDestinationPlace: (place) =>
                                    setState(() => _destinationPlace = place),
                                /*callback: (val) => setState(() => address = val),*/
                                key: _chooseKey,
                                onSelected: onSelected,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 300,
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: indexOfTab == 0
                                            ? primaryColor
                                            : Colors.transparent,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    top: BorderSide(
                                        color: Colors.transparent,
                                        style: BorderStyle.solid,
                                        width: 2))),
                            child: CupertinoButton(
                                pressedOpacity: 0.8,
                                padding: EdgeInsets.all(0),
                                child: Icon(
                                  Icons.directions_car,
                                  color: indexOfTab == 0
                                      ? primaryColor
                                      : Colors.blueGrey,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    indexOfTab = 0;
                                  });
                                  if (from != null && to != null) {
                                    await mapController?.clearLines();
                                    await WeMapDirections().loadRoute(
                                        mapController!,
                                        _route,
                                        insRoute,
                                        rootPreview,
                                        visible,
                                        indexOfTab,
                                        from!,
                                        to!);
                                    final json = await WeMapDirections()
                                        .getResponse(indexOfTab, from!, to!);
                                    setState(() {
                                      tripDistance =
                                          WeMapDirections().getDistance(json);
                                      price = tripDistance * 25000 / 1000;
                                      tripTime =
                                          WeMapDirections().getTime(json);
                                    });
                                  }
                                }),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: indexOfTab == 1
                                            ? primaryColor
                                            : Colors.transparent,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    top: BorderSide(
                                        color: Colors.transparent,
                                        style: BorderStyle.solid,
                                        width: 2))),
                            child: CupertinoButton(
                                pressedOpacity: 0.8,
                                padding: EdgeInsets.all(0),
                                child: Icon(
                                  Icons.directions_bike,
                                  color: indexOfTab == 1
                                      ? primaryColor
                                      : Colors.blueGrey,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    indexOfTab = 1;
                                  });
                                  if (from != null && to != null) {
                                    await mapController?.clearLines();
                                    await WeMapDirections().loadRoute(
                                        mapController!,
                                        _route,
                                        insRoute,
                                        rootPreview,
                                        visible,
                                        indexOfTab,
                                        from!,
                                        to!);
                                    final json = await WeMapDirections()
                                        .getResponse(indexOfTab, from!, to!);
                                    setState(() {
                                      tripDistance =
                                          WeMapDirections().getDistance(json);
                                      price = tripDistance * 10000 / 1000;
                                      tripTime =
                                          WeMapDirections().getTime(json);
                                    });
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 48,
            right: 0,
            left: 0,
            height: 50,
            child: Container(
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Total (" +
                            "${((tripDistance / 1000).toStringAsFixed(1))}" +
                            " km): ",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Text(
                        "${price.toInt().round()}" + "đ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ])),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightBlueAccent)),
                onPressed: () {},
                child: Text(
                  "Confirm Pickup",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
