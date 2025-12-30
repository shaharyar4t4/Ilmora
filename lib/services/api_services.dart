import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:ilmora/model/aya_of_the_day.dart';
import 'package:ilmora/model/juz.dart';
import 'package:ilmora/model/qari.dart';
import 'package:ilmora/model/sajada.dart';
import 'package:ilmora/model/surah.dart';
import 'package:ilmora/model/surahTranslationlist.dart';

class ApiServices {
  final String endPointUrl = "http://api.alquran.cloud/v1/surah";
  final String endPointUrlsajada = "https://api.alquran.cloud/v1/sajda/en.asad";

  final List<Surah> surahList = [];
  final List<Sajada> sajadaList = [];
  final List<Qari> qariList =[];

  // aya of the Day
  Future<AyaOfTheDay> getAyaOfTheDay() async {
    final int ayahNumber = _randomAyah(1, 6237);

    final String url =
        "http://api.alquran.cloud/v1/ayah/$ayahNumber/editions/quran-uthmani,en.asad,en.pickthall";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return AyaOfTheDay.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load Aya of the Day");
    }
  }

  int _randomAyah(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  // list of Surah
  Future<List<Surah>> getSurah() async {
    final http.Response res = await http.get(Uri.parse(endPointUrl));

    if (res.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(res.body);

      surahList.clear();

      for (var element in data['data']) {
        surahList.add(Surah.fromJson(element));
      }

      print("Total Surahs Loaded: ${surahList.length}");
      return surahList;
    } else {
      throw Exception("Can't get Surahs");
    }
  }

  // List of Sajada
  Future<List<Sajada>> getSadaja() async {
    final http.Response res = await http.get(Uri.parse(endPointUrlsajada));

    if (res.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(res.body);

      sajadaList.clear();

      final List ayahs = data['data']['ayahs'];

      for (var element in ayahs) {
        sajadaList.add(Sajada.fromJson(element['surah']));
      }

      print("Total Sajada Loaded: ${sajadaList.length}");
      return sajadaList;
    } else {
      throw Exception("Can't get Surahs");
    }
  }

  // list of juzz
  Future<JuzModel> getJuzz(int index) async {
  String url =
      "https://api.alquran.cloud/v1/juz/$index/quran-uthmani";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return JuzModel.fromJSON(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load Juz");
  }
}

// translation
Future<SurahTranslationList> getTranslation(int index, int translationIndex) async{
  String lan = "";

  if(translationIndex== 0){
    lan = "urdu_junagarhi";
  }else if(translationIndex == 1){
    lan = "hindi_omari";
  }else if(translationIndex == 2){
    lan = "english_saheeh";
  }else if(translationIndex == 3){
    lan = "spanish_garcia";
  }
  final url = "https://quranenc.com/api/v1/translation/sura/$lan/$index";
  var res = await http.get(Uri.parse(url));
  return SurahTranslationList.fromJSON(jsonDecode(res.body));
}

//qari list
Future <List<Qari>> getQariList() async{
  final url = 'https://quranicaudio.com/api/qaris';

  final res = await http.get(Uri.parse(url));

  jsonDecode(res.body).forEach((element){
    if(qariList.length< 20)
    qariList.add(Qari.fromjson(element));
  });

  qariList.sort((a,b) => a.name!.compareTo(b.name!));

  return qariList;
}
}
