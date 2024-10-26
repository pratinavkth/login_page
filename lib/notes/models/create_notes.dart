import 'dart:convert';

class CreateNotes{
  final String title;
  final String content;
  final String date;
  final String userId;
  

  CreateNotes({
    required this.title,
    required this.content,
    required this.date,
    required this.userId,
  });

  Map<String , dynamic> toMap(){
    return{
      'title': title,
      'content': content,
      'date': date,
      'userId':userId,

    };
  }

  factory CreateNotes.fromMap(Map<String, dynamic> map){
    return CreateNotes(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      date: map['date'] ?? '',
      userId: map['userId'] ??'',
    );
  }
  
  String toJson() => json.encode(toMap());
  factory CreateNotes.fromJson(String source) => CreateNotes.fromMap(json.decode(source));


}