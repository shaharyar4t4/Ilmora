import 'package:flutter/material.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/screens/main_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

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
              bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Customize Your reading veiw, read in multiple language, listen different audio", textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0),))],
              ),
              image: Center(child: Image.asset('assets/image/quran.png')),
            ),
            PageViewModel(
              title: "Prayer Alerts",
              bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Choose your adhan, which prayer to be notified of and how often", textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0),))],
              ),
              image: Center(child: Image.asset('assets/image/prayer.png')),
            ),
             PageViewModel(
              title: "Build better habits",
              bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Make Islamic practices a part of your daily life in a way that best suits your life", textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0),))],
              ),
              image: Center(child: Image.asset('assets/image/zakat.png')),
            ),
          ],
          // showSkipButton: true,
          // skip: const Icon(Icons.skip_next),
          onDone: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },

          showNextButton: true,
          next: const Icon(Icons.arrow_forward, color: Colors.black),
          done: const Text(
            "Done",
            style: TextStyle( color: Colors.black),
          ),
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Constants.kPrimary,
            color: Colors.grey,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }
}
