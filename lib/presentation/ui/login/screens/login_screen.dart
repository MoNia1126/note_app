import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/components/custom_text_button.dart';
import 'package:note_app/components/custom_elvated_button.dart';
import 'package:note_app/components/custom_text_form_field.dart';
import 'package:note_app/presentation/ui/home/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:note_app/presentation/ui/login/LoginCubit/login_cubit.dart';
import 'package:note_app/presentation/ui/login/LoginCubit/login_state.dart';
import 'package:note_app/presentation/ui/register/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            } else if (state is LoginFailure) {
              _showErrorDialog(context, state.error);
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
                            AppLocalizations.of(context)!.login,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'PlaywriteCU',
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
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
                          keyboardType: TextInputType.text,
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
                            height: MediaQuery.of(context).size.height * 0.04),
                        CustomElevatedButton(
                          text: AppLocalizations.of(context)!.login,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // loginCubit.signIn(context, emailController.text, passwordController.text);
                              context.read<LoginCubit>().signIn(
                                  context,
                                  emailController.text,
                                  passwordController.text);
                            }
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                AppLocalizations.of(context)!
                                    .doNotHaveAnAccount,
                                style: Theme.of(context).textTheme.titleMedium),
                            CustomTextButton(
                              text: AppLocalizations.of(context)!.signUp,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.routeName);
                              },
                            ),
                          ],
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
          title: Text((AppLocalizations.of(context)!.loginFailed)),
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
