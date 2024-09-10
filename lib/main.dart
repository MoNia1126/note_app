import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/home/home_screen.dart';
import 'package:note_app/home/login_screen.dart';
import 'package:note_app/home/register_screen.dart';
import 'package:note_app/home/setting_screen.dart';
import 'package:note_app/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:note_app/home/splash_screen.dart';
import 'cubits/changeLanguageCubit/change_language_cubit.dart';
import 'cubits/changeLanguageCubit/change_language_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:  (context) => ChangeLanguageCubit(),
      child: BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
          builder: (context, state) {
    return MaterialApp(
        title: 'Notes App',
        initialRoute: LoginScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
        },
        theme: MyTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        locale: state.locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // home: FirebaseAuth.instance.currentUser != null &&
        //       FirebaseAuth.instance.currentUser!.emailVerified
        //   ?HomeScreen ()
        //   : LoginScreen(),
      );}
    ));
  }
}

