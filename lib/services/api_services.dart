import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:ilmora/model/aya_of_the_day.dart';

class ApiServices {
  Future<AyaOfTheDay> getAyaOfTheDay() async {
    String url =
        "http://api.alquran.cloud/v1/ayah/${random(1, 6237)}/editions/quran-uthmani,en.asad,en.pickthall";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return AyaOfTheDay.fromJSON(json.decode(response.body));
    } else {
      print("Failed of Load");
      throw Exception("Failed to Load Post");
    }
  }

    random(min, max) {
      var rn = new Random();
      return min = rn.nextInt(max - min);
    }  
}
