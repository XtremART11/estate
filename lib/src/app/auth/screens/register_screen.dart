import 'package:estate/src/app/auth/auth_controller.dart';
import 'package:estate/src/app/main_screen.dart';
import 'package:estate/src/core/default_app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:refena_flutter/refena_flutter.dart';

import '../../../core/utils.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureText = true;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final ref = context.ref;
    final authState = context.watch(authControllerProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: AppDefaultSpacing(
        child: authState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          "assets/images/register.svg",
                          height: 250,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Vous avez déjà un compte ?',
                          ),
                          TextButton(
                            onPressed: () => navigateTo(context, const LoginScreen()),
                            child: const Text(
                              'Connectez-vous',
                            ),
                          ),
                        ],
                      ),
                      FormBuilder(
                          key: _formKey,
                          child: Column(children: [
                            FormBuilderTextField(
                              controller: nameController,
                              name: 'name',
                              decoration: const InputDecoration(labelText: 'Nom & prenom'),
                              validator: FormBuilderValidators.required(),
                            ),
                            const Gap(10),
                            FormBuilderTextField(
                              controller: phoneController,
                              name: 'phone',
                              decoration: const InputDecoration(labelText: 'Telephone'),
                              validator: FormBuilderValidators.numeric(),
                              keyboardType: TextInputType.number,
                            ),
                            const Gap(10),
                            FormBuilderTextField(
                              controller: emailController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              name: 'email',
                              decoration: const InputDecoration(labelText: 'Email'),
                              validator: FormBuilderValidators.email(),
                            ),
                            const Gap(10),
                            FormBuilderTextField(
                              obscureText: obscureText,
                              controller: passwordController,
                              name: 'password',
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () => setState(() {
                                      obscureText = !obscureText;
                                    }),
                                    child: obscureText
                                        ? const Icon(Icons.visibility_rounded)
                                        : const Icon(Icons.visibility_off_rounded),
                                  ),
                                  labelText: 'Mot de passe'),
                              validator: FormBuilderValidators.password(
                                minLength: 6,
                                minLowercaseCount: 0,
                                minNumberCount: 0,
                                minUppercaseCount: 0,
                                minSpecialCharCount: 0,
                              ),
                            ),
                            const Gap(20),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ref.notifier(authControllerProvider).registerAgent(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          onSuccess: () {
                                            showToast(context, 'Compte cree avec succes');
                                            navigateToReplace(context, const MainScreen());
                                          },
                                        );
                                  }
                                },
                                child: const Text('Créer mon compte')),
                            // const Text("S'inscrire en tant que Agent immobilier"),
                          ])),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
