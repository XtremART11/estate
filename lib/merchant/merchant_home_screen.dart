import 'package:estate/property/property_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class MerchantHomeScreen extends StatefulWidget {
  const MerchantHomeScreen({super.key});

  @override
  State<MerchantHomeScreen> createState() => _MerchantHomeScreenState();
}

class _MerchantHomeScreenState extends State<MerchantHomeScreen> {
  final propertyName = TextEditingController();
  final propertyPrice = TextEditingController();
  final propertyDescription = TextEditingController();
  final propertyLocation = TextEditingController();
  List? propertyPhotos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Ajouter une nouvelle propriete'),
            FormBuilder(
              child: Column(children: [
                FormBuilderTextField(
                  decoration: const InputDecoration(hintText: 'Name'),
                  name: 'name',
                  controller: propertyName,
                ),
                FormBuilderTextField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  name: 'price',
                  controller: propertyPrice,
                ),
                FormBuilderTextField(
                  decoration: const InputDecoration(labelText: 'Location'),
                  name: 'loccation',
                  controller: propertyLocation,
                ),
                FormBuilderTextField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  name: 'description',
                  controller: propertyDescription,
                ),
                FormBuilderImagePicker(
                  onChanged: (value) {
                    propertyPhotos = value;
                    setState(() {});
                  },
                  name: 'photos',
                  decoration: const InputDecoration(labelText: 'Pick Photos'),
                  maxImages: 1,
                ),
                ElevatedButton(
                    onPressed: () {
                      final property = PropertyRepository();
                      property.createProperty({
                        'uid': FirebaseAuth.instance.currentUser!.uid,
                        'name': propertyName.text,
                        'price': propertyPrice.text,
                        'description': propertyDescription.text,
                        'location': propertyLocation.text,
                        'image': propertyPhotos,
                      });
                    },
                    child: const Text('Envoyer'))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
