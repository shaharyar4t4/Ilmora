import 'package:flutter/material.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/model/surahTranslationlist.dart';
import 'package:ilmora/services/api_services.dart';
import 'package:ilmora/widget/translation_title.dart';

class SurahDetail extends StatefulWidget {
  const SurahDetail({super.key});

  static const String id = 'surahDetail_screen';

  @override
  State<SurahDetail> createState() => _SurahDetailState();
}

class _SurahDetailState extends State<SurahDetail> {

  ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: _apiServices.getTranslation(Constants.surahIndex!), builder: (BuildContext context, AsyncSnapshot<SurahTranslationList> snapshot)
      {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        else if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.translationList.length,
            itemBuilder: (context, index){
            return TranslationTitle(
              index: index,
              surahTranslation: snapshot.data!.translationList[index]
              );
          });
        }
        else {
          return Center(child: Text('No data available'));
        }
      }),
    );
  }
}