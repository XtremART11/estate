import 'package:estate/agent_profile_screen.dart';
import 'package:estate/default_app_spacing.dart';
import 'package:estate/main_screen.dart';
import 'package:estate/property/property_controller.dart';
import 'package:estate/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:gap/gap.dart';
import 'package:refena_flutter/refena_flutter.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final cityCtrl = TextEditingController();
  final quarterCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  List imageUrls = [];

  @override
  Widget build(BuildContext context) {
    final ref = context.ref;
    final propertyState = context.watch(propertyControllerProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une nouvelle propriété'),
      ),
      body: Center(
        child: propertyState.isLoading
            ? const CircularProgressIndicator()
            : DefaultAppSpacing(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilder(
                      child: Column(children: [
                        FormBuilderImagePicker(
                          onChanged: (value) {
                            setState(() {
                              imageUrls = value ?? [];
                            });
                          },
                          name: 'photos',
                          decoration: const InputDecoration(labelText: 'Selectionner des photos'),
                          maxImages: 4,
                        ),
                        const Gap(10),
                        FormBuilderTextField(
                          decoration: const InputDecoration(labelText: 'Quartier'),
                          name: 'quarter',
                          controller: quarterCtrl,
                        ),
                        const Gap(10),
                        FormBuilderTextField(
                          decoration: const InputDecoration(labelText: 'Ville'),
                          name: 'city',
                          controller: cityCtrl,
                        ),
                        const Gap(10),
                        FormBuilderTextField(
                          decoration: const InputDecoration(labelText: 'Prix'),
                          name: 'price',
                          controller: priceCtrl,
                        ),
                        const Gap(10),
                        FormBuilderTextField(
                          decoration: const InputDecoration(labelText: 'Coordonnées'),
                          name: 'location',
                          controller: locationCtrl,
                        ),
                        const Gap(10),
                        FormBuilderTextField(
                          decoration: const InputDecoration(labelText: 'Description'),
                          name: 'description',
                          controller: descriptionCtrl,
                        ),
                        const Gap(20),
                        ElevatedButton(
                            onPressed: () {
                              ref.notifier(propertyControllerProvider).addProperty(
                                    city: cityCtrl.text,
                                    price: priceCtrl.text,
                                    description: descriptionCtrl.text,
                                    imageUrls: imageUrls,
                                    location: locationCtrl.text,
                                    quarter: quarterCtrl.text,
                                    onSuccess: () => navigateTo(
                                      context,
                                      const AgentProfileScreen(),
                                    ),
                                  );
                            },
                            child: const Text('Envoyer'))
                      ]),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
