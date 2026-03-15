import 'package:app_cursos/pages/search_page.dart';
import 'package:app_cursos/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'my_courses.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _index = 0;

  final pages = const [
    HomePage(),
    SearchPage(),
    MeusCursosPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF7C3AED),

        onTap: (value) {
          setState(() {
            _index = value;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Pesquisa",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Cursos",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Config",
          ),
        ],
      ),
    );
  }
}