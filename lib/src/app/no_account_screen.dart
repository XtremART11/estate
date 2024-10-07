import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/auth/screens/login_screen.dart';
import 'package:estate/src/app/estate/estate_repository.dart';
import 'package:estate/src/core/default_app_spacing.dart';
import 'package:estate/src/core/utils.dart';
import 'package:flutter/material.dart';

import 'estate/widgets/estate_list_view.dart';

class NoAccountScreen extends StatelessWidget {
  const NoAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final estateRepo = EstateRepository();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estate'),
        actions: [
          TextButton(
              onPressed: () {
                navigateTo(context, const LoginScreen());
              },
              child: const Icon(Icons.login_outlined))
        ],
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
