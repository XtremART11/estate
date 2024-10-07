import 'package:estate/src/app/map/map_estate_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  final Map<String, dynamic> initialLocation;
  final List estates;

  const MapScreen({super.key, required this.estates, required this.initialLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
          options: MapOptions(
            keepAlive: true,
            initialZoom: 13,
            initialCenter: LatLng(
              double.parse(initialLocation['lat']),
              double.parse(initialLocation['long']),
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            PolygonLayer(
              polygons: [
                ...estates.map((e) {
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
              ...estates.map((e) => Marker(
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
                                estates: estates,
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
