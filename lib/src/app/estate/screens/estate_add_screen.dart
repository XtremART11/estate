import 'package:estate/src/app/agent/profile_screen.dart';
import 'package:estate/src/app/estate/estate_controller.dart';
import 'package:estate/src/core/default_app_spacing.dart';
import 'package:estate/src/core/log.dart';
import 'package:estate/src/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:refena_flutter/refena_flutter.dart';

class EstateAddScreen extends StatefulWidget {
  const EstateAddScreen({super.key});

  @override
  State<EstateAddScreen> createState() => _EstateAddScreenState();
}

class _EstateAddScreenState extends State<EstateAddScreen> {
  final cityCtrl = TextEditingController();
  final quarterCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final areaCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final locationLatCtrl = TextEditingController();
  final locationLongCtrl = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  List<Map<String, dynamic>> coordinates = [];
  List fileLinks = [];
  List featuredImageLink = [];

  @override
  Widget build(BuildContext context) {
    final ref = context.ref;
    final propertyState = context.watch(propertyControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une nouvelle propriété'),
      ),
      body: Center(
        child: propertyState.isLoading
            ? const CircularProgressIndicator()
            : AppDefaultSpacing(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormBuilder(
                        key: _formKey,
                        child: Column(children: [
                          FormBuilderImagePicker(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.required(),
                            onChanged: (value) {
                              setState(() {
                                featuredImageLink = value ?? [];
                              });
                            },
                            name: 'photos',
                            decoration: const InputDecoration(labelText: "Ajouter l'image de couverture"),
                            maxImages: 1,
                          ),
                          const Gap(10),
                          FormBuilderFilePicker(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.required(),
                            name: "fileLinks",
                            decoration: const InputDecoration(labelText: "Ajouter des images et videos"),
                            maxFiles: null,
                            allowMultiple: true,
                            previewImages: true,
                            onChanged: (val) {
                              for (var v in val!) {
                                fileLinks.add(v.xFile);
                              }
                              setState(() {});
                              logInfo(fileLinks);
                            },
                            typeSelectors: const [
                              TypeSelector(
                                type: FileType.any,
                                selector: Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add_circle),
                                      Gap(5),
                                      Text("Cliquer ici pour ajouter "),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.required(),
                            decoration: const InputDecoration(labelText: 'Quartier'),
                            name: 'quarter',
                            controller: quarterCtrl,
                          ),
                          const Gap(10),
                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.required(),
                            decoration: const InputDecoration(labelText: 'Ville'),
                            name: 'city',
                            controller: cityCtrl,
                          ),
                          const Gap(10),
                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.numeric(),
                            decoration: const InputDecoration(labelText: 'Prix (/m²)'),
                            name: 'price',
                            controller: priceCtrl,
                            keyboardType: TextInputType.number,
                          ),
                          const Gap(10),
                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(labelText: 'Superficie (m²)'),
                            name: 'area',
                            controller: areaCtrl,
                            validator: FormBuilderValidators.numeric(),
                            keyboardType: TextInputType.number,
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Expanded(
                                child: FormBuilderTextField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: FormBuilderValidators.numeric(),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(labelText: 'Localisation(latitude)'),
                                  name: 'locationLat',
                                  controller: locationLatCtrl,
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: FormBuilderTextField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: FormBuilderValidators.numeric(),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(labelText: 'Localisation(longitude)'),
                                  name: 'locationLong',
                                  controller: locationLongCtrl,
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.numeric(),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: 'Coordonnees'),
                            name: 'coordinates',
                            enabled: true,
                            onTap: () => showAdaptiveDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  final latitudeCtrl = TextEditingController();
                                  final longitudeCtrl = TextEditingController();
                                  return AlertDialog(
                                    title: const Text('Ajouter les points geographiques du terrain'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FormBuilderTextField(
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: FormBuilderValidators.numeric(),
                                          keyboardType: TextInputType.number,
                                          name: 'lat',
                                          decoration: const InputDecoration(labelText: 'Latitude'),
                                          controller: latitudeCtrl,
                                        ),
                                        const Gap(10),
                                        FormBuilderTextField(
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: FormBuilderValidators.numeric(),
                                          keyboardType: TextInputType.number,
                                          name: 'long',
                                          decoration: const InputDecoration(labelText: 'Longitude'),
                                          controller: longitudeCtrl,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          coordinates
                                              .add({'latitude': latitudeCtrl.text, 'longitude': longitudeCtrl.text});
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: const Text('Ajouter'),
                                      )
                                    ],
                                  );
                                }),
                          ),
                          const Gap(5),
                          Wrap(
                            children: coordinates
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Chip(
                                      label: Text('x:${e['latitude']} y:${e['longitude']}'),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const Gap(10),
                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.required(),
                            decoration: const InputDecoration(labelText: 'Description'),
                            name: 'description',
                            controller: descriptionCtrl,
                          ),
                          const Gap(20),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ref.notifier(propertyControllerProvider).addEstate(
                                        city: cityCtrl.text,
                                        price: priceCtrl.text,
                                        description: descriptionCtrl.text,
                                        fileLinks: fileLinks,
                                        featuredImageLink: featuredImageLink,
                                        coordinates: coordinates,
                                        location: {'lat': locationLatCtrl.text, 'long': locationLongCtrl.text},
                                        quarter: quarterCtrl.text,
                                        area: areaCtrl.text,
                                        onSuccess: () => {
                                          navigateTo(
                                            context,
                                            const ProfileScreen(),
                                          ),
                                          showToast(context, 'Propriete ajoutee avec success')
                                        },
                                      );
                                }
                              },
                              child: const Text('Ajouter'))
                        ]),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
