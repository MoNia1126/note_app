import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/presentation/ui/home/UserCubit/user_cubit.dart';
import 'package:note_app/presentation/ui/home/UserCubit/user_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      title: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return Text(
              '${AppLocalizations.of(context)!.welcome}, ${state.userName}',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontFamily: 'PlaywriteCU',
                  ),
            );
          } else if (state is UserError) {
            return Text(AppLocalizations.of(context)!.errorFetchingUserData);
          } else {
            return Text(AppLocalizations.of(context)!.welcome);
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
