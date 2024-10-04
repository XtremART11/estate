import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/log.dart';

class EstateCard extends StatelessWidget {
  final VoidCallback? onTap;
  const EstateCard({super.key, required this.estate, required this.onTap});

  final QueryDocumentSnapshot<Map<String, dynamic>> estate;

  @override
  Widget build(BuildContext context) {
    logInfo(estate['featuredImage']);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (estate['featuredImage']).isEmpty
                ? const SizedBox.shrink()
                : SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).width * 0.35,
                    child: Image.network(
                      estate['featuredImage'],
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(estate['city']),
                  Text('${estate['price']}/month'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
