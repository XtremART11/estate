import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/estate/estate_repository.dart';
import 'package:estate/src/core/default_app_spacing.dart';
import 'package:estate/src/core/utils.dart';
import 'package:flutter/material.dart';

import '../estate/screens/estate_list_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final estateRepo = EstateRepository();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estate'),
        actions: [
          IconButton(
              onPressed: () {
                navigateTo(context, const ProfileScreen());
              },
              icon: const Icon(Icons.person_2_outlined))
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: estateRepo.getEstates(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return AppDefaultSpacing(
              child: EstateListScreen(
            snapshot: snapshot,
          ));
        },
      ),
    );
  }
}
