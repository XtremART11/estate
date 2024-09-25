import 'package:estate/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        options: const MapOptions(
          initialZoom: 15,
          initialCenter: LatLng(51.5, -0.09),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayer(markers: [
            Marker(
                point: const LatLng(51.5, -0.09),
                child: IconButton(
                  color: Colors.green,
                  onPressed: () {
                    logInfo('message');
                  },
                  icon: const Icon(
                    Icons.pin_drop_outlined,
                    size: 50,
                  ),
                ))
          ]),
        ]);
  }
}
