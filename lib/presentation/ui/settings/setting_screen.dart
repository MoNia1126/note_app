import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/components/custom_confirmation_dialog.dart';
import 'package:note_app/presentation/cubits/changeLanguageCubit/change_language_cubit.dart';
import 'package:note_app/presentation/ui/login/screens/login_screen.dart';
import 'package:note_app/components/toast.dart';
import '../../../constants/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = 'setting';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsScreen> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text((AppLocalizations.of(context)!.language),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).primaryColor)),
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
                  style: const TextStyle(
                      color: Color(0xff005698),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              trailing: Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                showLanguageDialog();
              },
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MyTheme.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text((AppLocalizations.of(context)!.logOut),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.red)),
                ),
                IconButton(
                    onPressed: () async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomConfirmationDialog(
                              title: AppLocalizations.of(context)!.logout,
                              content: AppLocalizations.of(context)!
                                  .areYouSureYouWantToLogout,
                              action1: AppLocalizations.of(context)!.logout,
                              action2: AppLocalizations.of(context)!.cancel,
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                // showToast(
                                //     message: (AppLocalizations.of(context)!
                                //         .successfullySignedOut));
                                Navigator.of(context).pop();
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName);
                              },
                              pressed: () {
                                Navigator.of(context).pop(false);
                              });
                        },
                      );
                    },
                    icon: const Icon(Icons.logout_outlined),
                    color: Colors.red)
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
              title: Text((AppLocalizations.of(context)!.english),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).primaryColor)),
              onTap: () {
                BlocProvider.of<ChangeLanguageCubit>(context)
                    .changeLanguageToEnglish();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text((AppLocalizations.of(context)!.arabic),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).primaryColor)),
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
}
