import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/presentation/cubits/changeLanguageCubit/change_language_cubit.dart';

class CustomLanguageContainer extends StatefulWidget {
  const CustomLanguageContainer({super.key});

  @override
  State<CustomLanguageContainer> createState() =>
      _CustomLanguageContainerState();
}

class _CustomLanguageContainerState extends State<CustomLanguageContainer> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).primaryColor)),
          trailing: Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).primaryColor,
          ),
          onTap: () {
            showLanguageDialog();
          },
        ),
      ),
    ]);
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
