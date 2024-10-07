import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/estate/estate_repository.dart';
import 'package:flutter/material.dart';

import '../core/default_app_spacing.dart';
import 'estate/widgets/estate_list_view.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final estateRepo = EstateRepository();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: AppDefaultSpacing(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: estateRepo.getEstates(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return EstateListView(
              snapshot: snapshot,
            );
          },
        ),
      ),
    );
  }
}
