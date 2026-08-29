import 'package:adnc/pages/home/index.dart';
import 'package:adnc/pages/home/punch_in.dart';
import 'package:adnc/pages/home/punch_out.dart';
import 'package:adnc/pages/home/punch_success.dart';
import 'package:adnc/pages/landing.dart';
import 'package:adnc/pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/punch-in': (context) => const PunchInPage(),
        '/punch-out': (context) => const PunchOutPage(),
        '/punch-success': (context) => const PunchSuccessPage(),
      },
      title: 'App Care',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Color(0xFF0066ff))),
    );
  }
}
