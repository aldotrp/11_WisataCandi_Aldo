import 'package:flutter/material.dart';
import 'package:wisatacandi_aldo/data/candi_data.dart';
import 'package:wisatacandi_aldo/screens/Search_Screen.dart';
import 'package:wisatacandi_aldo/screens/favorite_screen.dart';
import 'package:wisatacandi_aldo/screens/home_screen.dart';
import 'package:wisatacandi_aldo/screens/profile_screen.dart';
import 'package:wisatacandi_aldo/screens/sign_in_screen.dart';
import 'package:wisatacandi_aldo/screens/sign_up_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.deepPurple),
            titleTextStyle: TextStyle(
              color: Colors.deepPurple,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          primary: Colors.deepPurple,
          surface: Colors.deepPurple[50],
        ),
      ),
      home: SignUpScreen(),
      initialRoute: '/',
      routes: {
        '/homescreen': (context) => const MainScreen(),
        '/signin': (context) =>  SignInScreen(),
        '/signup': (context) =>  SignUpScreen(),
        },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //todo 1 : deklarasi variable
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
    FavoriteScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // todo 2: buat properti body berupa wwidget yang ditampilkan
      body: _children[_currentIndex],
      // todo 3: buat properti bottomNavigation dengan nilai theme
      bottomNavigationBar: 
      Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.deepPurple[50]),
          child: BottomNavigationBar(
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.deepPurple[100],
            showSelectedLabels: true,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
            });
            },
            items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.deepPurple),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.deepPurple,),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.deepPurple),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.deepPurple),
              label: 'Favorite',
            ),
          ]
          )),
      // todo 4: buat data dan child dari theme
    );
  }
}
