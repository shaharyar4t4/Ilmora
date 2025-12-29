import 'package:flutter/material.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/model/surahTranslationlist.dart';
import 'package:ilmora/services/api_services.dart';
import 'package:ilmora/widget/translation_title.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

enum Translation {urdu, hindi, english, spanish}

class SurahDetail extends StatefulWidget {
  const SurahDetail({super.key});

  static const String id = 'surahDetail_screen';

  @override
  State<SurahDetail> createState() => _SurahDetailState();
}

class _SurahDetailState extends State<SurahDetail> {

  final ApiServices _apiServices = ApiServices();
  // SolidController _controller = SolidController();
  Translation? _translation = Translation.urdu;
  

  @override
  Widget build(BuildContext context) {
    print(_translation!.index);
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _apiServices.getTranslation(
            Constants.surahIndex!, 
          _translation!.index,
            ), 
        builder: (BuildContext context, AsyncSnapshot<SurahTranslationList> snapshot)
        {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ListView.builder(
                itemCount: snapshot.data!.translationList.length,
                itemBuilder: (context, index){
                return TranslationTitle(
                  index: index,
                  surahTranslation: snapshot.data!.translationList[index]
                  );
              }),
            );
          }
          else {
            return Center(child: Text('No data available'));
          }
        }),
        bottomSheet: SolidBottomSheet(headerBar: Container(
          color: Theme.of(context).primaryColor,
          height: 50,
          child: Center(
            child: Text("Swipe me!", style: TextStyle(color: Colors.white),),
          ),
        ), body: Container(
          color: Colors.white,
          height: 30,
          child: SingleChildScrollView(
            child: Center(child: Center(
              child: Column(
                children: <Widget>[
                    ListTile(
                      title: const Text('Urdu'),
                      leading: Radio<Translation>(
                        value: Translation.urdu,
                        groupValue: _translation,
                        onChanged:(Translation? value){
                          setState(() {
                            _translation = value;
                          });
                        }
                      ),
                    ),
                    ListTile(
                      title: const Text('Hindi'),
                      leading: Radio<Translation>(
                        value: Translation.hindi,
                        groupValue: _translation,
                        onChanged:(Translation? value){
                          setState(() {
                            _translation = value;
                          });
                        }
                      ),
                    ),
                    ListTile(
                      title: const Text('English'),
                      leading: Radio<Translation>(
                        value: Translation.english,
                        groupValue: _translation,
                        onChanged:(Translation? value){
                          setState(() {
                            _translation = value;
                          });
                        }
                      ),
                    ),
                    ListTile(
                      title: const Text('Spanish'),
                      leading: Radio<Translation>(
                        value: Translation.spanish,
                        groupValue: _translation,
                        onChanged:(Translation? value){
                          setState(() {
                            _translation = value;
                          });
                        }
                      ),
                    )
                ],
              ),
            ),),
          ),
        )),
      ),
    );
  }
  
}