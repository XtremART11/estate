import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/agent/agent_repository.dart';
import 'package:estate/src/core/default_app_spacing.dart';
import 'package:estate/src/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class MapEstateDetail extends StatelessWidget {
  final List estates;
  final QueryDocumentSnapshot<Map<String, dynamic>> estate;

  const MapEstateDetail({super.key, required this.estate, required this.estates});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: [
              ...estate['fileUrls'].map((url) {
                return Builder(builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: CachedNetworkImage(
                      // height: screenH(context) * 0.4,
                      fit: BoxFit.cover,
                      imageUrl: url,
                    ),
                  );
                });
              })
            ],
            options: CarouselOptions(aspectRatio: 1.4, viewportFraction: 1, autoPlay: true),
          ),

          // Wrap(
          //   runSpacing: 10,
          //   spacing: 10,
          //   children: [

          //     ...estate['fileUrls'].map((url) {
          //       return Builder(builder: (BuildContext context) {
          //         return ClipRRect(
          //           borderRadius: const BorderRadius.all(Radius.circular(10)),
          //           child: CachedNetworkImage(
          //             height: screenH(context) * 0.1,
          //             fit: BoxFit.cover,
          //             imageUrl: url,
          //           ),
          //         );
          //       });
          //     })
          //   ],
          // ),

          const Gap(10),
          AppDefaultSpacing(
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5)),
                child: DefaultTextStyle(
                  style: textTheme(context).bodyLarge!.copyWith(color: const Color.fromARGB(255, 6, 43, 73)),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Superficie:',
                        ),
                        Text(estate['area'] + 'm²'),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Prix:'),
                        Text(estate['price'] + ' F/m²'),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ville :'),
                        Text(estate['city']),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Quartier:'),
                        Text(estate['quarter']),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Coordonnées:'),
                        Text(estate['location']['lat'] + ', ' + estate['location']['long']),
                      ],
                    ),
                    const Gap(5),
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: AgentRepository().getAgent(estate['agentId']),
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Nom du vendeur:'),
                                  snapshot.data?.data()?['name'] == null
                                      ? const Text('')
                                      : Text(snapshot.data!.data()?['name']),
                                ],
                              ),
                              const Gap(5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Telephone:'),
                                  snapshot.data?.data()?['phone'] == null
                                      ? const Text('')
                                      : Text(snapshot.data!.data()?['phone']),
                                  // Text(snapshot.data!.data()?['phone'] ?? ''),
                                ],
                              ),
                              const Gap(30),
                              ElevatedButton(
                                  onPressed: () async {
                                    final link = WhatsAppUnilink(
                                      phoneNumber: '+237${snapshot.data!.data()?['phone']}',
                                      text:
                                          "Je suis intéressé par le terrain en vente situé à *${estate['city']}* plus précisément au quartier *${estate['quarter']}*. Je souhaiterais avoir plus d'informations. Cordialement",
                                    );
                                    await launchUrl(link.asUri());
                                  },
                                  child: const Text("Contacter le vendeur")),
                            ],
                          );
                        }),
                  ]),
                )),
          ),
        ],
      ),
    );
  }
}
