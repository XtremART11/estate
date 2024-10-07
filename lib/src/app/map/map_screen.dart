import 'package:estate/src/app/map/map_estate_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  final Map<String, dynamic> initialLocation;
  final List estates;

  const MapScreen({super.key, required this.estates, required this.initialLocation});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  _getUserLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    setState(() {
      userLocation = LatLng(locationData.latitude!.toDouble(), locationData.longitude!.toDouble());
    });
  }

  final mapController = MapController();
  LatLng userLocation = const LatLng(4, 9);
  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
          mapController: mapController,
          options: MapOptions(
              onMapReady: () => mapController.move(const LatLng(7.532110, 12.960185), 6),
              keepAlive: true,
              initialZoom: 6,
              initialCenter: userLocation

              //double.parse(initialLocation['lat']),
              //double.parse(initialLocation['long']),

              ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            PolygonLayer(
              polygons: [
                ...widget.estates.map((e) {
                  return Polygon(
                    borderStrokeWidth: 2,
                    color: const Color.fromARGB(255, 164, 197, 224),
                    points: [
                      ...e['coordinates'].map((coord) {
                        final lat = double.parse(coord['latitude']);
                        final long = double.parse(coord['longitude']);
                        return LatLng(lat, long);
                      })
                    ],
                  );
                })
              ],
            ),
            MarkerLayer(rotate: true, markers: [
              ...widget.estates.map((e) => Marker(
                    alignment: const Alignment(0, -0.9),
                    point: LatLng(
                      double.parse(e['location']['lat']),
                      double.parse(e['location']['long']),
                    ),
                    child: GestureDetector(
                      onTap: () => showModalBottomSheet(
                          showDragHandle: true,
                          context: context,
                          builder: (context) => MapEstateDetail(
                                estate: e,
                                estates: widget.estates,
                              )),
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 35,
                      ),
                    ),
                  )),
            ]),
          ]),
    );
  }
}
