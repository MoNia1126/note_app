import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/presentation/ui/home/UserCubit/user_cubit.dart';
import 'package:note_app/presentation/ui/home/widgets/add_note_fAB.dart';
import 'package:note_app/presentation/ui/home/widgets/home_appbar.dart';
import 'package:note_app/presentation/ui/home/widgets/home_bottom_navigation_bar.dart';
import 'package:note_app/presentation/ui/noteList/screens/note_list_tab.dart';
import 'package:note_app/presentation/ui/settings/screens/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..fetchUserName(),
      child: Scaffold(
        appBar: const HomeAppBar(),
        bottomNavigationBar: HomeBottomNavigationBar(
          selectedIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        floatingActionButton: const AddNoteFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _getTab(selectedIndex),
      ),
    );
  }

  Widget _getTab(int index) {
    List<Widget> tabs = const [
      NoteListTab(),
      SettingsScreen(),
    ];
    return tabs[index];
  }
}
