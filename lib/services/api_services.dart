import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:ilmora/model/aya_of_the_day.dart';
import 'package:ilmora/model/surah.dart';

class ApiServices {
  final String endPointUrl = "http://api.alquran.cloud/v1/surah";

  final List<Surah> surahList = [];

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
}
