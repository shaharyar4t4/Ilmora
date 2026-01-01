class Tafseer {
  Tafseer({
    this.tafseerId,
    this.tafseerName,
    this.ayahUrl,
    this.ayahNumber,
    this.text,
  });

  Tafseer.fromJson(dynamic json) {
    tafseerId = json['tefseer_id'];
    tafseerName = json['tafseer_name'];
    ayahUrl = json['ayah_url'];
    ayahNumber = json['ayah_number'];
    text = json['text'];
  }

  int? tafseerId;
  String? tafseerName;
  String? ayahUrl;
  String? ayahNumber;
  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tafseer_id'] = tafseerId;
    map['tafseer_name'] = tafseerName;
    map['ayah_url'] = ayahUrl;
    map['text'] = text;
    return map;
  }
}
