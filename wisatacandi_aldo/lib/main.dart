import 'package:flutter/material.dart';
import 'package:wisatacandi_aldo/data/candi_data.dart';
import 'package:wisatacandi_aldo/screens/Search_Screen.dart';
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
    return  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color : Colors.deepPurple),
          titleTextStyle: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          primary: Colors.deepPurple,
          surface: Colors.deepPurple[50],
        ),
        
      ),
      // home: DetailScreen(candi: candiList[0],),
      // {"conversationId":"220f923f-b9cf-4630-8467-b6cf6ef1afa2","source":"instruct"}
      // home : const ProfileScreen(),
      // home : SignInScreen(),
      // home : SignUpScreen(),
      // home : SearchScreen(),
      home : HomeScreen()
    );
  }
}

