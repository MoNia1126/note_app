import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/components/custom_confirmation_dialog.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/presentation/ui/login/screens/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomLogout extends StatelessWidget {
  const CustomLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomConfirmationDialog(
                title: AppLocalizations.of(context)!.logout,
                content:
                    AppLocalizations.of(context)!.areYouSureYouWantToLogout,
                action1: AppLocalizations.of(context)!.logout,
                action2: AppLocalizations.of(context)!.cancel,
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
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
      child: Container(
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
                      .titleSmall!
                      .copyWith(color: MyTheme.redColor)),
            ),
            const Icon(Icons.logout_outlined, color: Colors.red)
          ],
        ),
      ),
    );
  }
}
