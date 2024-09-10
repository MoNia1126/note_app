import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:note_app/cache_helper.dart';
import 'package:note_app/components/custom_elvated_button.dart';
import 'package:note_app/components/custom_text_button.dart';
import 'package:note_app/components/custom_text_form_field.dart';
import 'package:note_app/cubits/LoginCubit/login_state.dart';
import 'package:note_app/home/home_screen.dart';
import 'package:note_app/home/register_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuthService();


  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
                          AppLocalizations.of(context)!.login,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'PlaywriteCU',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      CustomTextFormField(
                        prefixIcon: Icon(Icons.email, color: Colors.grey.shade300),
                        hintText: '${(AppLocalizations.of(context)!.enterYourEmail)}',
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
                        prefixIcon: Icon(Icons.password, color: Colors.grey.shade300),
                        hintText: '${(AppLocalizations.of(context)!.enterYourPassword)}',
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
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
    //                   BlocConsumer<LoginCubit, LoginState>(
    //                   listener: (context, state) {
    // if (state is LoginSuccess) {
    // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    // } else if (state is LoginError) {
    // AwesomeDialog(
    // context: context,
    // dialogType: DialogType.error,
    // animType: AnimType.rightSlide,
    // title: 'Login Failed',
    // desc: state.error,
    // ).show();
    // }
    // },
    // builder: (context, state) {
    // if (state is LoginLoading) {
    // return Center(child: CircularProgressIndicator());
    // }
                      CustomElevatedButton(text: '${(AppLocalizations.of(context)!.login)}',
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                User? user = await _auth.signInWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text,
                                );
                                if (user != null && user.emailVerified) {
                                  CacheHelper.saveData(key: "userId", value: user.uid);
                                  Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                                } else if (!user!.emailVerified) {
                                  await user.sendEmailVerification();
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error',
                                    desc: 'Please verify your email to continue.',
                                  ).show();
                                }
                              } on FirebaseAuthException catch (e) {
                                // Handle login errors
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Login Failed',
                                  desc: e.message,
                                ).show();
                              }
                            }
                          }
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${(AppLocalizations.of(context)!.doNotHaveAnAccount)}',
                              style: Theme.of(context).textTheme.titleMedium),
                          CustomTextButton(
                              text: '${(AppLocalizations.of(context)!.signUp)}',
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.routeName);
                              }),
                        ],
                      )
                    ]),
              ))
        ],
      ),
    );
  }
  // void login() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isLoggedIn', true);
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(builder: (context) => HomeScreen()),
  //   );
  // }
}
