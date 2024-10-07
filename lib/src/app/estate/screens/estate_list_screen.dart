import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/estate/widgets/estate_list_view.dart';
import 'package:flutter/material.dart';

class EstateListScreen extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  const EstateListScreen({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EstateListView(snapshot: snapshot),
    );
  }
}
