import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/constants/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:note_app/presentation/ui/login/LoginCubit/login_cubit.dart';
import 'package:note_app/presentation/ui/login/LoginCubit/login_state.dart';
import 'package:note_app/components/background_image.dart';
import 'package:note_app/presentation/ui/login/widgets/custom_login_button.dart';
import 'package:note_app/presentation/ui/login/widgets/email_input_field.dart';
import 'package:note_app/presentation/ui/login/widgets/login_title.dart';
import 'package:note_app/presentation/ui/login/widgets/password_input_field.dart';
import 'package:note_app/presentation/ui/login/widgets/signup_option.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            } else if (state is LoginFailure) {
              _showErrorDialog(context, state.error);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                const BackgroundImage(),
                Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
                        const LoginTitle(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        EmailInputField(controller: emailController),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        PasswordInputField(controller: passwordController),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        LoginButton(
                          formKey: formKey,
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        const SignUpOption(),
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
              child: Text((AppLocalizations.of(context)!.ok),
                  style: TextStyle(color: Theme.of(context).primaryColor)),
            ),
          ],
        );
      },
    );
  }
}