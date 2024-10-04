import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/auth/screens/login_screen.dart';
import 'package:estate/src/app/estate/estate_repository.dart';
import 'package:estate/src/core/default_app_spacing.dart';
import 'package:estate/src/core/utils.dart';
import 'package:flutter/material.dart';

import 'agent/home_screen.dart';
import 'estate/widgets/estate_card.dart';

class NoAccountScreen extends StatelessWidget {
  const NoAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final property = PropertyRepository();
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
          stream: property.getEstates(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 15,
                childAspectRatio: 0.7,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final estate = snapshot.data!.docs[index];
                return EstateCard(
                  estate: estate,
                  onTap: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}
