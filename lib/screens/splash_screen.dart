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

  bool alreadyUsed =false;

  void getData() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.getBool("alreadyUsed") ?? false;
    // onboreding screen show on will first time
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    Timer(const Duration(seconds: 3), () {
      MaterialPageRoute(builder: (context){
        return alreadyUsed? MainScreen(): OnboradingScreen();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text(
              "Ilmora",
              style: TextStyle(color: Colors.black, fontSize: 40.0, fontFamily: 'Poppins'),
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
