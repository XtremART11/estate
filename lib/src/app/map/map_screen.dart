import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:estate/src/app/map/map_estate_detail.dart';
import 'package:estate/src/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:refena_flutter/refena_flutter.dart';

class MapScreen extends StatefulWidget {
  final Map<String, dynamic>? initialLocation;
  final List estates;

  const MapScreen({super.key, required this.estates, required this.initialLocation});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with SingleTickerProviderStateMixin {
  late final _animatedMapController =
      AnimatedMapController(vsync: this, duration: Duration(milliseconds: 5000), curve: Curves.easeInOut);
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

  LatLng userLocation = const LatLng(4, 9);
  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cachePath = context.watch(pathProvider);
    return Scaffold(
      body: FlutterMap(
          mapController: _animatedMapController.mapController,
          options: MapOptions(
            onMapReady: () {
              if (widget.initialLocation!.isNotEmpty) {
                _animatedMapController.animateTo(
                    zoom: 19,
                    dest: LatLng(
                        double.parse(widget.initialLocation?['lat']), double.parse(widget.initialLocation?['long'])));
              }
            },
            keepAlive: true,
            initialZoom: 6,
            initialCenter: widget.initialLocation!.isNotEmpty
                ? LatLng(
                    double.parse(widget.initialLocation?['lat']),
                    double.parse(widget.initialLocation?['long']),
                  )
                : userLocation,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              tileProvider: CachedTileProvider(
                maxStale: Duration(days: 7),
                store: HiveCacheStore(cachePath),
              ),
            ),
            PolygonLayer(
              polygons: [
                ...widget.estates.map((e) {
                  return Polygon(
                    borderStrokeWidth: 2,
                    color: e['landTitle'].isNotEmpty
                        ? Colors.red.withOpacity(0.2)
                        : const Color.fromARGB(255, 164, 197, 224),
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
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => MapEstateDetail(
                                estate: e,
                                estates: widget.estates,
                              )),
                      child: Icon(
                        Icons.location_pin,
                        color: e['landTitle'].isNotEmpty ? Colors.red : Colors.blue,
                        size: 35,
                      ),
                    ),
                  )),
            ]),
          ]),
    );
  }
}
