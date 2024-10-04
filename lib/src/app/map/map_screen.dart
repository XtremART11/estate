import 'package:estate/src/core/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  final Map<String, dynamic> location;
  final List coordinates;
  const MapScreen({super.key, required this.location, required this.coordinates});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        options: MapOptions(
          keepAlive: true,
          initialZoom: 12,
          initialCenter: LatLng(
            double.parse(location['lat']),
            double.parse(location['long']),
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          PolygonLayer(
            polygons: [
              Polygon(
                borderStrokeWidth: 2,
                points: coordinates
                    .map(
                      (e) => LatLng(
                        double.parse(e['latitude']),
                        double.parse(e['longitude']),
                      ),
                    )
                    .toList(),
                color: const Color.fromARGB(255, 164, 197, 224),
              ),
            ],
          ),
          MarkerLayer(rotate: true, markers: [
            Marker(
              alignment: const Alignment(0, -0.9),
              point: LatLng(
                double.parse(location['lat']),
                double.parse(location['long']),
              ),
              child: GestureDetector(
                onTap: () => logInfo("SFSFSDFS"),
                child: const Icon(
                  Icons.location_history_outlined,
                  size: 35,
                ),
              ),
            )
          ]),
        ]);
  }
}
