class Surah {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  int? numberofAyahs;
  String? revelationType;

  Surah({this.number, this.name, this.englishName, this.englishNameTranslation, this.numberofAyahs, this.revelationType});

  factory Surah.fromJson(Map<String, dynamic> json){
    return Surah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      numberofAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
    );
  }
}