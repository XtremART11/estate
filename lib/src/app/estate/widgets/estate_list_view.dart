import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/utils.dart';
import '../screens/estate_detail_screen.dart';
import 'estate_card.dart';

class EstateListView extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  const EstateListView({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        final estate = snapshot.data!.docs[index];
        return EstateCard(
          estate: estate,
          onTap: () async {
            navigateTo(
                context,
                EstateDetailScreen(
                  estate: estate,
                  estates: snapshot.data!.docs,
                ));
            
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 15);
      },
    );
  }
}
