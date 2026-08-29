import 'dart:async';
import 'package:adnc/services/account.dart';
import 'package:adnc/services/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _accountService = AccountService();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () async {
      if (!mounted) return;
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      if (!mounted) return;
      if (accessToken != null && accessToken.isNotEmpty) {
        HttpsService.accessToken = accessToken;
        await _accountService.getProfile();
        // TODO: Manage error
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, '/home', ((route) => false));
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          ((route) => false),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF00265A), Color(0xFF0151A8)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo1.png',
                // width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
