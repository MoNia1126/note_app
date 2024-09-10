import 'package:flutter/material.dart';
import 'package:note_app/components/task_list.dart';
import 'package:note_app/home/setting_screen.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          '${(AppLocalizations.of(context)!.welcome)}',
          //  ${authProvider.currentUser!.name}',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontFamily: 'PlaywriteCU'
        ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "${(AppLocalizations.of(context)!.taskList)}",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "${(AppLocalizations.of(context)!.settings)}",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    TaskListScreen(),
    SettingsScreen(),
  ];

  // void showAddTaskBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => AddTaskBottomSheet(),
  //   );
  // }
}

