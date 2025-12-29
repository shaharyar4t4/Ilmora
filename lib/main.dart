import 'package:flutter/material.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/screens/juz_screen.dart';
import 'package:ilmora/screens/splash_screen.dart';
import 'package:ilmora/screens/surah_detail.dart';

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
        primaryColor: Constants.kPrimary,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(),
      routes: {
        JuzScreen.id: (context)=> JuzScreen(),
        SurahDetail.id: (context) => SurahDetail(),
      },
    );
  }
}
