import 'package:flutter/material.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/screens/main_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboradingScreen extends StatefulWidget {
  const OnboradingScreen({super.key});

  @override
  State<OnboradingScreen> createState() => _OnboradingScreenState();
}

class _OnboradingScreenState extends State<OnboradingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Read Quran",
              bodyWidget: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Customize your reading view, read in multiple languages and listen to different audio recitations.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              image: Center(child: Image.asset('assets/image/quran.png')),
            ),
            PageViewModel(
              title: "Prayer Alerts",
              bodyWidget: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Choose your adhan, select prayers to be notified and manage reminders easily.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              image: Center(child: Image.asset('assets/image/prayer.png')),
            ),
            PageViewModel(
              title: "Build Better Habits",
              bodyWidget: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Make Islamic practices part of your daily life in a simple and meaningful way.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              image: Center(child: Image.asset('assets/image/zakat.png')),
            ),
          ],

          onDone: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('alreadyUsed', true);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
            );
          },

          showNextButton: true,
          next: const Icon(Icons.arrow_forward, color: Colors.black),
          done: const Text(
            "Done",
            style: TextStyle(color: Colors.black),
          ),
          dotsDecorator: DotsDecorator(
            size: const Size.square(10),
            activeSize: const Size(20, 10),
            activeColor: Constants.kPrimary,
            color: Colors.grey,
            spacing: const EdgeInsets.symmetric(horizontal: 3),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }
}
