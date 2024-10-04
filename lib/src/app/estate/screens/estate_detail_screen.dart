import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/map/map_screen.dart';
import 'package:estate/src/core/utils.dart';
import 'package:flutter/material.dart';

import '../../../core/default_app_spacing.dart';

class EstateDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> estate;

  const EstateDetailScreen({super.key, required this.estate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppDefaultSpacing(
        child: Column(
          children: [
            // Featured image here
            SizedBox(height: 300, child: Image.network(estate['featuredImage'])),
            ElevatedButton(
                onPressed: () {
                  navigateTo(
                      context,
                      MapScreen(
                        location: estate['location'],
                        coordinates: estate['coordinates'],
                      ));
                },
                child: const Text('Location'))
          ],
        ),
      ),
    );
  }
}
