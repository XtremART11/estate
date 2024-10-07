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
        color: const Color(0xffF5F4F8),
        elevation: 0.1,
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
                        height: screenH(context) * 0.23,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.red.shade300,
                            ),
                            Text("${estate['quarter']},"),
                            Text(" ${estate['city']}"),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.square_foot_rounded,
                          color: Colors.blue,
                        ),
                        Text(
                          '${estate['area']}m²',
                          style: textTheme(context).bodyLarge?.copyWith(color: const Color(0xff8f92a8)),
                        ),
                      ],
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
