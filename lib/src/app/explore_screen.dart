import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/estate/estate_repository.dart';
import 'package:estate/src/core/log.dart';
import 'package:estate/src/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:gap/gap.dart';

import '../core/default_app_spacing.dart';
import 'estate/widgets/estate_list_view.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String query = '';
  Set<String> cities = {};
  @override
  Widget build(BuildContext context) {
    final estateRepo = EstateRepository();
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
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
                      // child: FormBuilderTextField(
                      //     onChanged: (value) => setState(() => query = value ?? ''),
                      //     name: 'name',
                      //     decoration: InputDecoration(
                      //         filled: true,
                      //         fillColor: Colors.grey.withOpacity(0.1),
                      //         prefixIcon: Icon(Icons.search),
                      //         labelText: 'Rechercher un terrain',
                      //         contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      //         isDense: true,
                      //         enabledBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(100),
                      //             borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))),
                      //         border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(100),
                      //             borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))),
                      //         focusedBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(100),
                      //           borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                      //         ))),
                      child: FormBuilderTypeAhead<String>(
                        
                        itemSeparatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            color: Colors.grey.withOpacity(0.15),
                          ),
                        ),
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
                            )),
                        onSelected: (p0) => setState(() => query = p0),
                        name: 'name',
                        itemBuilder: (context, suggestion) {
                          return ListTile(title: Text(suggestion));
                        },
                        suggestionsCallback: (pattern) {
                          return cities.where((city) => city.toLowerCase().contains(pattern.toLowerCase())).toList();
                        },
                      ),
                    ),
                    Gap(10),
                    IconButton(onPressed: () {}, icon: SvgPicture.asset("assets/images/filter.svg"))
                  ],
                ),
                Gap(10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    PlotFilter(
                      label: "Filtre",
                      onSelected: (onSelected) {},
                    ),
                    Gap(10),
                    PlotFilter(
                      label: "Prix",
                      onSelected: (onSelected) {},
                    ),
                    Gap(10),
                    PlotFilter(
                      label: "Type de propriété",
                      onSelected: (onSelected) {},
                    ),
                    Gap(10),
                    PlotFilter(
                      label: 'Localisation',
                      onSelected: (bool onSelected) {},
                    ),
                    Gap(10),
                    PlotFilter(
                      label: "Superficie",
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
          stream: estateRepo.getEstates('', query),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isNotEmpty) {
              for (var element in snapshot.data!.docs) {
                cities.add(element['city']);
              }
              logInfo(cities);
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

class PlotFilter extends StatelessWidget {
  final String label;
  final Function(bool onSelected) onSelected;
  const PlotFilter({
    super.key,
    required this.label,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      deleteIcon: Icon(Icons.filter_alt_outlined),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.symmetric(vertical: 2),
      backgroundColor: Colors.transparent,
      labelStyle: textTheme(context).bodySmall?.copyWith(),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000), side: BorderSide(color: Colors.grey.withOpacity(0.08))),
      label: Text(label),
      onSelected: onSelected,
    );
  }
}
