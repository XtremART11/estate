import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/agent/agent_repository.dart';
import 'package:estate/src/app/map/map_screen.dart';
import 'package:estate/src/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../core/default_app_spacing.dart';

class EstateDetailScreen extends StatelessWidget {
  final List estates;
  final QueryDocumentSnapshot<Map<String, dynamic>> estate;

  const EstateDetailScreen({super.key, required this.estate, required this.estates});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail sur la propriété'),
      ),
      body: AppDefaultSpacing(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: CarouselSlider(
                      items: [
                        ...estate['fileUrls'].map((url) {
                          return Builder(builder: (BuildContext context) {
                            return CachedNetworkImage(
                              // height: screenH(context) * 0.4,
                              fit: BoxFit.cover,
                              imageUrl: url,
                            );
                          });
                        })
                      ],
                      options: CarouselOptions(
                          aspectRatio: 1.2, enlargeCenterPage: true, viewportFraction: 1, autoPlay: true),
                    ),
                  ),
                  Positioned(
                      right: 20,
                      top: 10,
                      child: IconButton.filled(
                          color: Colors.black26,
                          style: IconButton.styleFrom(backgroundColor: Colors.white),
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border_rounded)))
                ],
              ),
              const Gap(30),
              GestureDetector(
                onTap: () {
                  navigateTo(
                      context,
                      MapScreen(
                        estates: estates,
                        initialLocation: estate['location'],
                      ));
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.blue.withOpacity(0.2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.map_rounded,
                          color: Color.fromARGB(255, 6, 43, 73),
                          size: 30,
                        ),
                        const Gap(5),
                        Text('Voir sur la carte',
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(fontSize: 18, color: const Color.fromARGB(255, 6, 43, 73))),
                      ],
                    )),
              ),
              const Gap(20),
              Container(
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
                          Text(estate['area'] + ' m²'),
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
                                        : Text(snapshot.data?.data()?['name']),
                                  ],
                                ),
                                const Gap(5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Telephone:'),
                                    snapshot.data?.data()?['phone'] == null
                                        ? const Text('')
                                        : Text(snapshot.data?.data()?['phone']),
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
            ],
          ),
        ),
      ),
    );
  }
}
