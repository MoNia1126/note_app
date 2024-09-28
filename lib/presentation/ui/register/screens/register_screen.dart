import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_app/components/background_image.dart';
import 'package:note_app/components/custom_elvated_button.dart';
import 'package:note_app/components/custom_text_button.dart';
import 'package:note_app/constants/routes.dart';
import 'package:note_app/presentation/ui/login/screens/login_screen.dart';
import 'package:note_app/presentation/ui/register/RegisterCubit/register_cubit.dart';
import 'package:note_app/presentation/ui/register/RegisterCubit/register_state.dart';
import 'package:note_app/presentation/ui/register/widgets/back_button_widget.dart';
import 'package:note_app/presentation/ui/register/widgets/header_text.dart';
import 'package:note_app/presentation/ui/register/widgets/input_fields.dart';
import '../../home/screens/home_screen.dart';

class RegisterScreen extends StatelessWidget {

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButtonWidget(),
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
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            } else if (state is RegisterError) {
              _showErrorDialog(context, state.errorMessage);
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
                        HeaderText(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08),
                        InputFields(
                          userNameController: userNameController,
                          emailController: emailController,
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
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
                          },
                        ),
                        CustomTextButton(
                          text: AppLocalizations.of(context)!
                              .alreadyHaveAnAccount,
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.login);
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