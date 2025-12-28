class Sajada {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  int? numberofAyahs;
  String? revelationType;

  Sajada({this.number, this.name, this.englishName, this.englishNameTranslation, this.numberofAyahs, this.revelationType});

  factory Sajada.fromJson(Map<String, dynamic> json){
    return Sajada(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      numberofAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
    );
  }
}