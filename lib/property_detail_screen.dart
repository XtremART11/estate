import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/map.dart';
import 'package:estate/utils.dart';
import 'package:flutter/material.dart';

import 'default_app_spacing.dart';

class PropertyDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> estate;

  const PropertyDetailScreen({super.key, required this.estate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultAppSpacing(
        child: Column(
          children: [
            // Featured image here
            SizedBox(height: 300, child: Image.network(estate['imageUrls'][0])),
            ElevatedButton(
                onPressed: () {
                  navigateTo(context, const MapScreen());
                },
                child: const Text('Location'))
          ],
        ),
      ),
    );
  }
}
