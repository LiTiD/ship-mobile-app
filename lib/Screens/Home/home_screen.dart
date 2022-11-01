import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/constant.dart';
import 'package:flutter_auth/Screens/Home/model/model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      title: 'Ship Convenient',
      home: MapBox(),
    );
  }
}

class MapBox extends StatefulWidget {
  const MapBox({Key? key}) : super(key: key);

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> with TickerProviderStateMixin {
  final pageController = PageController();
  int selectedIndex = 0;
  var currentLocation = AppConstants.myLocation;

  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  Future<LatLng> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var mylocation = await Geolocator.getCurrentPosition();

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return LatLng(mylocation.latitude, mylocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    void _animatedMapMove(LatLng destLocation, double destZoom) {
      final latTween = Tween<double>(
          begin: mapController.center.latitude, end: destLocation.latitude);
      final lngTween = Tween<double>(
          begin: mapController.center.longitude, end: destLocation.longitude);
      final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);
      var controller = AnimationController(
          duration: const Duration(milliseconds: 1000), vsync: this);
      Animation<double> animation =
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
      controller.addListener(() {
        mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation),
        );
      });
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.dispose();
        } else if (status == AnimationStatus.dismissed) {
          controller.dispose();
        }
      });
      controller.forward();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('Ship Convenient'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              interactiveFlags:
                  InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              center: LatLng(10.841034273185302, 106.80986976566365),
              zoom: 10.5,
              minZoom: 5,
              maxZoom: 18.4,
              slideOnBoundaries: true,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/full9saoxec/cl9y7t2o3000k15qiljama6h9/tiles/256/{z}/{x}/{y}@2x?access_token={access_token}",
                additionalOptions: {
                  "access_token":
                      "pk.eyJ1IjoiZnVsbDlzYW94ZWMiLCJhIjoiY2w5eTduMHo0MDI4eDNvcWwwbGprbG5jZCJ9.bwl8bUXXggxb-hJ1g-RItQ",
                },
              ),
              PolylineLayer(
                polylineCulling: false,
                polylines: [
                  Polyline(
                    points: [
                      LatLng(10.845987, 106.814935),
                      LatLng(10.845288, 106.815471),
                      LatLng(10.844549, 106.814421),
                      LatLng(10.844199, 106.814728),
                      LatLng(10.844091, 106.814885),
                      LatLng(10.843695, 106.814411),
                      LatLng(10.842956, 106.815241),
                      LatLng(10.839578, 106.812006),
                      LatLng(10.839529, 106.811947),
                      LatLng(10.839509, 106.811107),
                      LatLng(10.839589, 106.810980),
                      LatLng(10.840311, 106.810192),
                      LatLng(10.840419, 106.810142),
                      LatLng(10.840599, 106.810252),
                      LatLng(10.841065, 106.809775),
                    ],
                    strokeWidth: 5,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
              CurrentLocationLayer(),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  var currentLocation = await _determinePosition();
                  // mapController.move(currentLocation, 15);
                  _animatedMapMove(currentLocation, 15);
                },
                child: Icon(Icons.my_location),
              ),
              ElevatedButton(
                onPressed: () async {
                  var bounds = LatLngBounds();
                  List<LatLng> ways = [
                      LatLng(10.845987, 106.814935),
                      LatLng(10.845288, 106.815471),
                      LatLng(10.844549, 106.814421),
                      LatLng(10.844199, 106.814728),
                      LatLng(10.844091, 106.814885),
                      LatLng(10.843695, 106.814411),
                      LatLng(10.842956, 106.815241),
                      LatLng(10.839578, 106.812006),
                      LatLng(10.839529, 106.811947),
                      LatLng(10.839509, 106.811107),
                      LatLng(10.839589, 106.810980),
                      LatLng(10.840311, 106.810192),
                      LatLng(10.840419, 106.810142),
                      LatLng(10.840599, 106.810252),
                      LatLng(10.841065, 106.809775),
                    ];
                  for(var x in ways){
                    bounds.extend(x);
                  }
                  bounds.pad(15);
                  bounds.extend(LatLng(10.835596948004833, 106.8087110514264));
                  var centerZoom = mapController.centerZoomFitBounds(bounds);
                  _animatedMapMove(centerZoom.center,centerZoom.zoom);
                },
                child: Icon(Icons.ac_unit_sharp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
