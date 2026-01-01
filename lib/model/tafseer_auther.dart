class TafseerAuthor{
  TafseerAuthor({
    this.id,
    this.name,
    this.language,
    this.author,
    this.bookName,
  });

  TafseerAuthor.fromJson(dynamic json){
    id = json['id'];
    name = json['name'];
    language = json['language'];
    author = json['author'];
    bookName = json['book_name'];
  }

  int? id;
  String? name;
  String? language;
  String? author;
  String? bookName;

  Map<String, dynamic> toJson(){
    final map = <String, dynamic >{};
      map['id'] =id;
      map['name'] = name;
      map ['language'] = language;
      map['author'] = author;
      map['book_name'] = bookName;
      return map;
  }
}