import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:ilmora/constant/constants.dart';
import 'qiblah_compass.dart';

class QiblahScreen extends StatelessWidget {
  const QiblahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kPrimary,
        centerTitle: true,
        title: const Text("Qiblah Compass", style: TextStyle(color: Colors.white),)),
      body: Container(
        color: Colors.white,  
        child: FutureBuilder<bool?>(
          future: deviceSupport,
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
        
            if (snapshot.data == false) {
              return const Center(
                child: Text("Device not supported"),
              );
            }
        
            return QiblahCompass();
          },
        ),
      ),
    );
  }
}
