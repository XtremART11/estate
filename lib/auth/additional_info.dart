import 'package:estate/auth/auth_repository.dart';
import 'package:estate/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../home_screen.dart';

class AdditionalInfos extends StatefulWidget {
  final String uid;
  const AdditionalInfos({super.key, required this.uid});

  @override
  State<AdditionalInfos> createState() => _AdditionalInfosState();
}

class _AdditionalInfosState extends State<AdditionalInfos> {
  final box = Hive.box('currentUserInfo');
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  String userRole = '';
  @override
  Widget build(BuildContext context) {
    logInfo(widget.uid);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Completer le profil'),
            FormBuilder(
              child: Column(
                children: [
                  FormBuilderTextField(
                    decoration: const InputDecoration(hintText: 'Name'),
                    name: 'name',
                    controller: nameCtrl,
                  ),
                  FormBuilderTextField(
                    decoration: const InputDecoration(hintText: 'Phone'),
                    name: 'phone',
                    controller: phoneCtrl,
                  ),
                  FormBuilderDropdown(onChanged: (value) => userRole = value.toString(), name: 'role', items: const [
                    DropdownMenuItem(
                      value: 'client',
                      child: Text('Client'),
                    ),
                    DropdownMenuItem(
                      value: 'merchant',
                      child: Text('Marchand'),
                    ),
                  ]),
                  FormBuilderTextField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    name: 'email',
                    controller: emailCtrl,
                  ),
                 
                  ElevatedButton(
                      onPressed: () async {
                        await AuthRepository().completeProfile(
                          uid: widget.uid,
                          name: nameCtrl.text,
                          role: userRole,
                          phone: phoneCtrl.text,
                          email: emailCtrl.text,
                        );
                        box.put('userRole', userRole);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                      child: const Text('Valider')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
