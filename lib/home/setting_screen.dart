import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:note_app/cubits/changeLanguageCubit/change_language_cubit.dart';
import 'package:note_app/home/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = 'setting';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsScreen> {
  final _auth = FirebaseAuthService();

  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15),
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('${(AppLocalizations.of(context)!.language)}',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme
                  .of(context)
                  .primaryColor)),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: MyTheme.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              title: Text(AppLocalizations.of(context)!.english,
                  style: TextStyle(color: Color(0xff005698), fontSize: 18)),
              trailing: Icon(
                Icons.arrow_drop_down,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              onTap: () {
                showLanguageDialog();
              },
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MyTheme.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${(AppLocalizations.of(context)!.logOut)}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.red)),
                ),
                IconButton(onPressed: () async {
                  await _auth.signOut();
                 logout();
                }, icon: Icon(Icons.logout_outlined), color: Colors.red)
              ],
            ),
          )
        ]));
  }

  void showLanguageDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('${(AppLocalizations.of(context)!.english)}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme
                      .of(context)
                      .primaryColor)),
              onTap: () {
                BlocProvider.of<ChangeLanguageCubit>(context)
                    .changeLanguageToEnglish();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('${(AppLocalizations.of(context)!.arabic)}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme
                      .of(context)
                      .primaryColor)),
              onTap: () {
                BlocProvider.of<ChangeLanguageCubit>(context)
                    .changeLanguageToArabic();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

}
