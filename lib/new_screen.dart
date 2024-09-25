import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real Estate App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Explore Nearby Estates section
          const Text(
            'Explore Nearby Estates',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: nearbyEstates.length,
            itemBuilder: (context, index) {
              final estate = nearbyEstates[index];
              return EstateCard(estate: estate);
            },
          ),
        ],
      ),
    );
  }
}

// EstateCard widget
class EstateCard extends StatelessWidget {
  const EstateCard({super.key, required this.estate});

  final Estate estate;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(estate.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(estate.name),
                Text('${estate.price}/month'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Estate class
class Estate {
  final String name;
  final String imageUrl;
  final int price;

  Estate({required this.name, required this.imageUrl, required this.price});
}

// List of featured estates
final List<Estate> featuredEstates = [
  Estate(name: 'Sky Dandelions Apartment', imageUrl: 'https://example.com/estate1.jpg', price: 290),
  Estate(name: 'Wings Tower', imageUrl: 'https://example.com/estate2.jpg', price: 220),
  // ... other featured estates
];

// List of nearby estates
final List<Estate> nearbyEstates = [
  Estate(name: 'Bungalow House', imageUrl: 'https://example.com/estate3.jpg', price: 235),
  Estate(name: 'Mill Sper House', imageUrl: 'https://example.com/estate4.jpg', price: 271),
  // ... other nearby estates
];
