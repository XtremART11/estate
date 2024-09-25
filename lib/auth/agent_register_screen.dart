import 'package:estate/default_app_spacing.dart';
import 'package:estate/auth/auth_controller.dart';
import 'package:estate/main_screen.dart';
import 'package:estate/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:refena_flutter/refena_flutter.dart';

class AgentRegisterScreen extends StatefulWidget {
  const AgentRegisterScreen({super.key});

  @override
  State<AgentRegisterScreen> createState() => _AgentRegisterScreenState();
}

class _AgentRegisterScreenState extends State<AgentRegisterScreen> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ref = context.ref;
    final authState = context.watch(authControllerProvider);
    final textTheme = Theme.of(context).textTheme;
    return DefaultAppSpacing(
      child: authState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Creer un compte',
                  style: textTheme.headlineMedium,
                ),
                Text(
                  'Inscrivez-vous en tant que agent immobilier',
                  style: textTheme.bodyMedium,
                ),
                const Gap(30),
                FormBuilder(
                    child: Column(children: [
                  FormBuilderTextField(
                    controller: nameCtrl,
                    name: 'name',
                    decoration: const InputDecoration(labelText: 'Nom'),
                  ),
                  const Gap(10),
                  FormBuilderTextField(
                    controller: phoneCtrl,
                    name: 'phone',
                    decoration: const InputDecoration(labelText: 'Telephone'),
                  ),
                  const Gap(10),
                  FormBuilderTextField(
                    controller: emailCtrl,
                    name: 'email',
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const Gap(10),
                  FormBuilderTextField(
                    controller: passwordCtrl,
                    name: 'password',
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      ref.notifier(authControllerProvider).registerAgent(
                            name: nameCtrl.text,
                            phone: phoneCtrl.text,
                            email: emailCtrl.text,
                            password: passwordCtrl.text,
                            onSuccess: () => navigateTo(
                              context,
                              const MainScreen(),
                            ),
                          );
                    },
                    child: const Text('Creer mon compte'),
                  ),
                  // const Text("S'inscrire en tant que Agent immobilier"),
                ])),
              ],
            ),
    );
  }
}
