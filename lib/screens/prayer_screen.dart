import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  final Location location = Location();

  double? latitude;
  double? longitude;

  /// Get current location
  Future<void> getLoc() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final locData = await location.getLocation();
    latitude = locData.latitude;
    longitude = locData.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.kPrimary,
          centerTitle: true,
          title: const Text(
            "Prayer Timings",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder(
          future: getLoc(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (latitude == null || longitude == null) {
              return const Center(child: Text("Location not available"));
            }

            final coordinates = Coordinates(latitude!, longitude!);

            final CalculationParameters params =
                CalculationMethodParameters.karachi();
            params.madhab = Madhab.hanafi;

            final DateTime now = DateTime.now().toLocal();

            final PrayerTimes prayerTimes = PrayerTimes(
              coordinates: coordinates,
              date: now,
              calculationParameters: params,
            );

            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  buildRow("Fajr", prayerTimes.fajr),
                  divider(),
                  buildRow("Sunrise", prayerTimes.sunrise),
                  divider(),
                  buildRow("Dhuhr", prayerTimes.dhuhr),
                  divider(),
                  buildRow("Asr", prayerTimes.asr),
                  divider(),
                  buildRow("Maghrib", prayerTimes.maghrib),
                  divider(),
                  buildRow("Isha", prayerTimes.isha),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// UI Helper
  Widget buildRow(String title, DateTime? time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            time != null ? DateFormat.jm().format(time) : "--:--",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return const Divider(thickness: 1);
  }
}
