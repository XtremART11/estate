import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilder(
            child: Column(children: [
          FormBuilderTextField(
            name: '',
          ),
          FormBuilderTextField(
            name: '',
          ),
          FormBuilderTextField(
            name: '',
          ),
          FormBuilderTextField(
            name: '',
          ),
          // const Spacer(),
          const Text("S'inscrire en tant que Proprietaire foncier"),
        ])),
      ],
    );
  }
}
