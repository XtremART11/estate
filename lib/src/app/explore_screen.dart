import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/estate/estate_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';

import '../core/default_app_spacing.dart';
import 'estate/widgets/estate_list_view.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final estateRepo = EstateRepository();
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Explore'),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.filter_alt_outlined),
        //   )
        // ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppDefaultSpacing(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderTextField(
                          name: 'name',
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              prefixIcon: Icon(Icons.search),
                              labelText: 'Rechercher un terrain',
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                              ))),
                    ),
                    TextButton.icon(onPressed: () {}, icon: Icon(Icons.map_outlined), label: Text('Carte')),
                  ],
                ),
                Gap(10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    FilterChip(
                      deleteIcon: Icon(Icons.filter_alt_outlined),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.symmetric(vertical: 2),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000),
                          side: BorderSide(color: Colors.grey.withOpacity(0.2))),
                      label: Text('Filtre'),
                      onSelected: (onSelected) {},
                    ),
                    Gap(10),
                    FilterChip(
                      deleteIcon: Icon(Icons.filter_alt_outlined),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.symmetric(vertical: 2),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000),
                          side: BorderSide(color: Colors.grey.withOpacity(0.2))),
                      label: Text('Prix'),
                      onSelected: (onSelected) {},
                    ),
                    Gap(10),
                    FilterChip(
                      deleteIcon: Icon(Icons.filter_alt_outlined),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.symmetric(vertical: 2),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000),
                          side: BorderSide(color: Colors.grey.withOpacity(0.2))),
                      label: Text('Type de propriété'),
                      onSelected: (onSelected) {},
                    ),
                    Gap(10),
                    FilterChip(
                      deleteIcon: Icon(Icons.filter_alt_outlined),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.symmetric(vertical: 2),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000),
                          side: BorderSide(color: Colors.grey.withOpacity(0.2))),
                      label: Text('Localisation'),
                      onSelected: (onSelected) {},
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
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
