import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/property/property_repository.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final property = PropertyRepository();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: property.getProperties(),
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
              return EstateCard(estate: estate);
            },
          );
        },
      ),
    );
  }
}

class EstateCard extends StatelessWidget {
  const EstateCard({super.key, required this.estate});

  final QueryDocumentSnapshot<Map<String, dynamic>> estate;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(estate['image'].first, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(estate['name']),
                Text('${estate['price']}/month'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Estate {
  final String name;
  final String imageUrl;
  final String description;
  final int price;

  Estate({required this.description, required this.name, required this.imageUrl, required this.price});
}
