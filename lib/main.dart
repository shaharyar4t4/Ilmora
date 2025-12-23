import 'package:flutter/material.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ilmora',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Constants.kSwatchColor,
      ),
      home: SplashScreen(),
    );
  }
}
