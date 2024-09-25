import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_app/components/custom_elvated_button.dart';
import 'package:note_app/components/custom_text_button.dart';
import 'package:note_app/components/custom_text_form_field.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/presentation/ui/login/screens/login_screen.dart';
import 'package:note_app/presentation/ui/register/RegisterCubit/register_cubit.dart';
import 'package:note_app/presentation/ui/register/RegisterCubit/register_state.dart';
import '../../home/screens/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register';

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            },
            icon: Icon(Icons.arrow_back_ios_new, color: MyTheme.whiteColor)),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              Fluttertoast.showToast(
                  msg: state.message,
                  backgroundColor: Colors.green,
                  textColor: Colors.white);
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            } else if (state is RegisterError) {
              _showErrorDialog(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            return Stack(
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
                            height: MediaQuery.of(context).size.height * 0.2),
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.register,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'PlaywriteCU',
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08),
                        CustomTextFormField(
                          prefixIcon:
                              Icon(Icons.person, color: Colors.grey.shade300),
                          hintText:
                              AppLocalizations.of(context)!.enterYourUsername,
                          label: AppLocalizations.of(context)!.userName,
                          controller: userNameController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterUserName;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        CustomTextFormField(
                          prefixIcon:
                              Icon(Icons.email, color: Colors.grey.shade300),
                          hintText:
                              AppLocalizations.of(context)!.enterYourEmail,
                          label: AppLocalizations.of(context)!.email,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterEmail;
                            }
                            bool emailValid = RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                            ).hasMatch(text);
                            if (!emailValid) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterAValidEmail;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        CustomTextFormField(
                          prefixIcon:
                              Icon(Icons.password, color: Colors.grey.shade300),
                          hintText:
                              AppLocalizations.of(context)!.enterYourPassword,
                          label: AppLocalizations.of(context)!.password,
                          controller: passwordController,
                          obscureText: true,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterPassword;
                            }
                            if (text.length < 6) {
                              return AppLocalizations.of(context)!
                                  .passwordShouldHaveAtLeast6Chars;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        CustomTextFormField(
                          prefixIcon:
                              Icon(Icons.password, color: Colors.grey.shade300),
                          hintText: AppLocalizations.of(context)!
                              .enterYourConfirmationPassword,
                          label: AppLocalizations.of(context)!.confirmPassword,
                          controller: confirmPasswordController,
                          obscureText: true,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterConfirmPassword;
                            }
                            if (text != passwordController.text) {
                              return AppLocalizations.of(context)!
                                  .passwordDoesNotMatch;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        CustomElevatedButton(
                            text: AppLocalizations.of(context)!.register,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<RegisterCubit>().register(
                                    context,
                                    emailController.text,
                                    passwordController.text,
                                    userNameController.text);
                              }
                            }),
                        CustomTextButton(
                          text: AppLocalizations.of(context)!
                              .alreadyHaveAnAccount,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(LoginScreen.routeName);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text((AppLocalizations.of(context)!.registrationFailed)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text((AppLocalizations.of(context)!.ok)),
            ),
          ],
        );
      },
    );
  }
}
