import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:ilmora/constant/constants.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}
 
class _PrayerScreenState extends State<PrayerScreen> {
  final Location location = Location();
  double? latitude, longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kPrimary,
        title: const Text("Prayer Timing", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getLoc(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final coordinates = Coordinates(
            latitude ?? 33.7699,
            longitude ?? 72.8248,
          );
          final params = CalculationMethod.karachi.getParameters();
          params.madhab = Madhab.hanafi;

          final prayerTimes = PrayerTimes.today(coordinates, params);

          return Column(
            children: [
              buildRow("Fajr", prayerTimes.fajr),
              buildRow("Sunrise", prayerTimes.sunrise),
              buildRow("Dhuhr", prayerTimes.dhuhr),
              buildRow("Asr", prayerTimes.asr),
              buildRow("Maghrib", prayerTimes.maghrib),
              buildRow("Isha", prayerTimes.isha),
            ],
          );
        },
      ),
    );
  }

  Widget buildRow(String title, DateTime time) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18,)),
          Text(DateFormat.jm().format(time)),
        ],
      ),
    );
  }
  Future<void> getLoc() async {
    if (!await location.serviceEnabled()) {
      await location.requestService();
    }

    if (await location.hasPermission() == PermissionStatus.denied) {
      await location.requestPermission();
    }

    final loc = await location.getLocation();
    latitude = loc.latitude;
    longitude = loc.longitude;
  }
}
