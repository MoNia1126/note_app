import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:note_app/components/custom_elvated_button.dart';
import 'package:note_app/components/custom_text_button.dart';
import 'package:note_app/components/custom_text_form_field.dart';
import 'package:note_app/home/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuthService();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/main_back.jpg",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Center(
                      child: Text(
                        '${(AppLocalizations.of(context)!.register)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'PlaywriteCU',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    CustomTextFormField(
                      prefixIcon:
                          Icon(Icons.person, color: Colors.grey.shade300),
                      hintText:
                          '${(AppLocalizations.of(context)!.enterYourUsername)}',
                      label: '${(AppLocalizations.of(context)!.userName)}',
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return '${(AppLocalizations.of(context)!.pleaseEnterUserName)}';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextFormField(
                      prefixIcon:
                          Icon(Icons.email, color: Colors.grey.shade300),
                      hintText:
                          '${(AppLocalizations.of(context)!.enterYourEmail)}',
                      label: '${(AppLocalizations.of(context)!.email)}',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return '${(AppLocalizations.of(context)!.pleaseEnterEmail)}';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return '${(AppLocalizations.of(context)!.pleaseEnterAValidEmail)}';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextFormField(
                      prefixIcon:
                          Icon(Icons.password, color: Colors.grey.shade300),
                      hintText:
                          '${(AppLocalizations.of(context)!.enterYourPassword)}',
                      label: '${(AppLocalizations.of(context)!.password)}',
                      keyboardType: TextInputType.number,
                      controller: passwordController,
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return '${(AppLocalizations.of(context)!.pleaseEnterPassword)}';
                        }

                        if (text.length < 6) {
                          return '${(AppLocalizations.of(context)!.passwordShouldHaveAtLeast6Chars)}';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextFormField(
                      prefixIcon:
                          Icon(Icons.password, color: Colors.grey.shade300),
                      hintText:
                          '${(AppLocalizations.of(context)!.enterYourConfirmationPassword)}',
                      label:
                          '${(AppLocalizations.of(context)!.confirmPassword)}',
                      keyboardType: TextInputType.number,
                      controller: confirmPasswordController,
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return '${(AppLocalizations.of(context)!.pleaseEnterConfirmPassword)}';
                        }
                        if (text != passwordController.text) {
                          return '${(AppLocalizations.of(context)!.passwordDoesNotMatch)}';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    CustomElevatedButton(
                        text: '${(AppLocalizations.of(context)!.register)}',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              User? user =
                                  await _auth.signUpWithEmailAndPassword(
                                emailController.text,
                                passwordController.text,
                              );
                              if (user != null) {
                                await user.sendEmailVerification();
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'Success',
                                  desc:
                                      'Registration successful! Please verify your email.',
                                ).show();
                              }
                            } on FirebaseAuthException catch (e) {
                              // Handle registration errors
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Registration Failed',
                                desc: e.message,
                              ).show();
                            }
                          }
                        }),

                    // _signup
                    CustomTextButton(
                        text:
                            '${(AppLocalizations.of(context)!.alreadyHaveAnAccount)}',
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        }),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

