import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ilmora/screens/audio_screen.dart';
import 'package:ilmora/screens/home_screen.dart';
import 'package:ilmora/screens/prayer_screen.dart';
import 'package:ilmora/screens/quran_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectindex = 0;
  List<Widget> _widgetsList = [
    HomeScreen(),
    QuranScreen(),
    AudioScreen(),
    PrayerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _widgetsList[selectindex],
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Image.asset('assets/image/home.png'), title: 'Home'),
            TabItem(icon: Image.asset('assets/image/holyQuran.png'), title: 'Quran'),
            TabItem(icon: Image.asset('assets/image/audio.png'), title: 'Audio'),
            TabItem(icon: Image.asset('assets/image/prayer.png'), title: 'Prayer'),
          ],
          initialActiveIndex: 0,
          onTap:updateIndex,
        ),
      ),
    );
  }
  void updateIndex(index){
    setState(() {
      selectindex = index;
    });
  }
}
