import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ilmora/screens/main_screen.dart';
import 'package:ilmora/screens/onborading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _checkFirstTimeAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final alreadyUsed = prefs.getBool('alreadyUsed') ?? false;

    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            alreadyUsed ? const MainScreen() : const OnboradingScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkFirstTimeAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text(
              "Ilmora",
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset("assets/image/islamic.png"),
          ),
        ],
      ),
    );
  }
}
