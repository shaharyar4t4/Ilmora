import 'dart:async';
import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

import 'location_error_widget.dart';

class QiblahCompass extends StatefulWidget {
  const QiblahCompass({super.key});

  @override
  State<QiblahCompass> createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> {
  final StreamController<LocationStatus> _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  Stream<LocationStatus> get stream => _locationStreamController.stream;

  Future<void> _checkLocationStatus() async {
    final status = await FlutterQiblah.checkLocationStatus();

    if (!status.enabled) {
      _locationStreamController.add(status);
      return;
    }

    if (status.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final newStatus = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.add(newStatus);
    } else {
      _locationStreamController.add(status);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  @override
  void dispose() {
    _locationStreamController.close();
    FlutterQiblah().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocationStatus>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final status = snapshot.data!;

        if (!status.enabled) {
          return LocationErrorWidget(
            error: "Please enable location service",
            callback: _checkLocationStatus,
          );
        }

        switch (status.status) {
          case LocationPermission.always:
          case LocationPermission.whileInUse:
            return const QiblahCompassWidget();

          case LocationPermission.denied:
            return LocationErrorWidget(
              error: "Location permission denied",
              callback: _checkLocationStatus,
            );

          case LocationPermission.deniedForever:
            return LocationErrorWidget(
              error: "Location permission permanently denied",
              callback: _checkLocationStatus,
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}

class QiblahCompassWidget extends StatelessWidget {
  const QiblahCompassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 320, // ✅ FIXED SIZE
        width: 320,
        child: StreamBuilder<QiblahDirection>(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final qiblah = snapshot.data!;

            return Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: -(qiblah.direction * pi / 180),
                  child: SvgPicture.asset(
                    'assets/image/compass.svg',
                    width: 300,
                  ),
                ),
                Transform.rotate(
                  angle: -(qiblah.qiblah * pi / 180),
                  child: SvgPicture.asset(
                    'assets/image/needle.svg',
                    height: 200,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Text(
                    "${qiblah.offset.toStringAsFixed(1)}°",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
