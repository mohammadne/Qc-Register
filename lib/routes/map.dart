import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:qc_register/provider/app_provider.dart';

class MapRoute extends StatefulWidget {
  final Position initPosition;
  MapRoute(this.initPosition);
  @override
  _MapRouteState createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  MapController mapController;
  LatLng _currentScreenPosition;

  @override
  void initState() {
    super.initState();
    _currentScreenPosition =
        LatLng(widget.initPosition.latitude, widget.initPosition.longitude);
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              onPositionChanged: (MapPosition _mapPosition, bool val) {
                _currentScreenPosition = _mapPosition.center;
              },
              center: _currentScreenPosition,
              zoom: 16,
              maxZoom: 18,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png",
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: FloatingActionButton.extended(
                        backgroundColor: Colors.white,
                        label: Text("تایید لوکیشن و خروج"),
                        onPressed: () {
                          Provider.of<AppProvider>(context, listen: false)
                              .editWorkShop(
                            locationManual: _currentScreenPosition,
                          );
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: FloatingActionButton(
                      child: Icon(Icons.gps_fixed, color: Colors.black),
                      onPressed: () async {
                        await _getCurrentLocation();
                      },
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 48.0,
          ),
        ],
      ),
    );
  }

  _getCurrentLocation() async {
    await Geolocator().checkGeolocationPermissionStatus();
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _currentScreenPosition = LatLng(position.latitude, position.longitude);
      mapController.move(_currentScreenPosition, 16);
    }).catchError((e) {
      print(e);
    });
  }
}
