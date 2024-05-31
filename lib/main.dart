import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:poster_app/features/authentication/presentation/pages/login.dart';

import 'features/poster/presentation/pages/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static String LOGIN_KEY = 'isLoggedIn';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.grey,
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            subtitle2: TextStyle(fontSize: 12),
          )),
      home: const LoginPage(),
    );
  }
}