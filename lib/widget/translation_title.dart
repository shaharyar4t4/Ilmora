import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/model/surahTranslationlist.dart';
import 'package:ilmora/services/api_services.dart';

class TranslationTitle extends StatelessWidget {
  final int index;
  final SurahTranslation surahTranslation;

  TranslationTitle({
    super.key,
    required this.index,
    required this.surahTranslation,
  });

  final ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(blurRadius: 1)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: const BoxDecoration(
                    color: Constants.kSwatchColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),

                /// Ayah number
                Positioned(
                  top: 5,
                  bottom: 2,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Text(
                      surahTranslation.aya ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),

                /// Tafseer button
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    surahTranslation.arabic_text ?? '',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    surahTranslation.translation ?? '',
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
