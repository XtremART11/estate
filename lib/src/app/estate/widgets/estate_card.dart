import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/log.dart';
import '../../../core/utils.dart';

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
        // color: const Color(0xffF5F4F8),
        color: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              (estate['featuredImage']).isEmpty
                  ? const SizedBox.shrink()
                  : ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: CachedNetworkImage(
                        imageUrl: estate['featuredImage'],
                        height: screenH(context) * 0.3,
                        width: screenW(context),
                        fit: BoxFit.cover,
                      ),
                    ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultTextStyle(
                      style: textTheme(context).bodyLarge!.copyWith(color: const Color.fromARGB(255, 8, 24, 51)),
                      child: Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultTextStyle(
                              style: textTheme(context)
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w600, color: const Color.fromARGB(255, 8, 24, 51)),
                              // child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     Text("${estate['quarter']},"),
                              //     Text(" ${estate['city']}"),
                              //   ],
                              // ),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                subtitle: Wrap(
                                  children: [
                                    Text(
                                      '${estate['price']} Fcfa/m²,',
                                      style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      estate['landTitle'].isNotEmpty ? 'Titre de propriété' : 'Non Titré',
                                      style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                trailing: Text("${estate['area']} m²"),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("${estate['quarter']},"),
                                    Text(" ${estate['city']}"),
                                  ],
                                ),
                              ),
                            ),
                            // Gap(5),
                            // Text(
                            //   'Superfice : ${estate['area']}m²',
                            //   style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
                            // ),
                            // Gap(3),
                            // Text(
                            //   'Prix/m² : ${estate['price']}m²',
                            //   style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
                            // ),
                            // Gap(3),
                            // Text(
                            //   'Titré : ${estate['price']}m²',
                            //   style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         const Icon(Icons.location_city_rounded),
              //         Text(" ${estate['quarter']}"),
              //       ],
              //     ),
              //     Row(
              //       mainAxisSize: MainAxisSize.min,
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         const Icon(Icons.square_foot_rounded),
              //         Text('${estate['price']}F /m²'),
              //       ],
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
