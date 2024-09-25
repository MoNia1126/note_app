import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/presentation/ui/home/UserCubit/user_cubit.dart';
import 'package:note_app/presentation/ui/home/UserCubit/user_state.dart';
import 'package:note_app/presentation/ui/settings/setting_screen.dart';
import 'package:note_app/constants/my_theme.dart';
import 'package:note_app/presentation/ui/taskList/screens/task_list_tab.dart';
import 'package:note_app/presentation/ui/taskList/widgets/add_task_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..fetchUserName(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const CircularProgressIndicator();
              } else if (state is UserLoaded) {
                return Text(
                  '${(AppLocalizations.of(context)!.welcome)}, ${state.userName}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontFamily: 'PlaywriteCU',
                      ),
                );
              } else if (state is UserError) {
                return Text(
                    (AppLocalizations.of(context)!.errorFetchingUserData));
              } else {
                return Text(AppLocalizations.of(context)!.welcome);
              }
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: MediaQuery.of(context).size.height * 0.097,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.list),
                label: (AppLocalizations.of(context)!.taskList),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: (AppLocalizations.of(context)!.settings),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              // isScrollControlled: true,
              context: context,
              builder: (context) {
                // padding: MediaQuery.of(context).viewInsets.bottom;
                return SingleChildScrollView(
                  child: Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: AddTaskBottomSheet(),
                  ),
                );
              },
            );
          },
          child: Icon(
            Icons.add,
            size: 33,
            color: MyTheme.whiteColor,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: tabs[selectedIndex],
      ),
    );
  }

  List<Widget> tabs = [
    const TaskListTab(),
    const SettingsScreen(),
  ];
}
