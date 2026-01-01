import 'package:flutter/material.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/model/surahTranslationlist.dart';
import 'package:ilmora/services/api_services.dart';
import 'package:ilmora/widget/translation_title.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

enum Translation { urdu, hindi, english, spanish }

class SurahDetail extends StatefulWidget {
  const SurahDetail({super.key});

  static const String id = 'surahDetail_screen';

  @override
  State<SurahDetail> createState() => _SurahDetailState();
}

class _SurahDetailState extends State<SurahDetail> {
  final ApiServices _apiServices = ApiServices();
  final SolidController _solidController = SolidController();

  Translation _translation = Translation.urdu;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<SurahTranslationList>(
          future: _apiServices.getTranslation(
            Constants.surahIndex!,
            _translation.index,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemCount: snapshot.data!.translationList.length,
                itemBuilder: (context, index) {
                  return TranslationTitle(
                    index: index,
                    surahTranslation:
                        snapshot.data!.translationList[index],
                  );
                },
              ),
            );
          },
        ),
        bottomSheet: SolidBottomSheet(
          controller: _solidController,
          draggableBody: true,
          headerBar: Container(
            height: 50,
            color: Theme.of(context).primaryColor,
            child: const Center(
              child: Text(
                "Swipe me!",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
  body: SizedBox(
    height: 260, // 👈 controlled height (important)
    child: ListView(
      children: [
        _radioTile('Urdu', Translation.urdu),
        _radioTile('Hindi', Translation.hindi),
        _radioTile('English', Translation.english),
        _radioTile('Spanish', Translation.spanish),
      ],
    ),
  ),
))
    );
  }

  Widget _radioTile(String title, Translation value) {
    return ListTile(
      title: Text(title),
      leading: Radio<Translation>(
        value: value,
        groupValue: _translation,
        onChanged: (val) {
          setState(() {
            _translation = val!;
          });
          _solidController.hide();
        },
      ),
    );
  }
}
