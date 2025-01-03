import 'dart:convert';

class Notes{
  final String title;
  final String content;
  final String date;
  final String userId;
  String? noteId;
  

  Notes({
    required this.title,
    required this.content,
    required this.date,
    required this.userId,
    this.noteId,
  });

  Map<String,dynamic> toMap(){
    return{
      'title': title,
      'content': content,
      'date': date,
      'userId':userId,
      'noteId':noteId,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map){
    return Notes(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      date: map['date'] ?? '',
      userId: map['userId'] ??'',
      noteId: map['_id'] ??'',
    );
  }
  String toJson() => json.encode(toMap());
  factory Notes.fromJson(String source) => Notes.fromMap(json.decode(source));
}


class FetchNotes{
  final String title;
  final String content;
  final String date;
  final String? noteId;

  
  FetchNotes({
    required this.title,
    required this.content,
    required this.date,
    this.noteId,
  });
  Map<String ,dynamic> toMap()=>{
    'title':title,
    'content':content,
    'date':date, 
  };

  factory FetchNotes.fromMap(Map<String,dynamic>map){
    return FetchNotes(
      title: map['title']??'', 
      content: map['content']??'', 
      date: map['date']??'',
      noteId: map['_id']??'',
      // date: DateTime.parse(map['date']).toString(),
      );
  }
String toJson() => json.encode(toMap());
factory FetchNotes.fromJson(String source) => FetchNotes.fromMap(json.decode(source));

}

// class EditNotes{
//   final String title;
//   final String content;
//   final String date;

//   EditNotes({
//     required this.title,
//     required this.content,
//     required this.date,
//   });

//   Map<String,dynamic> toMap()=>{
//     'title':title,
//     'content':content,
//     'date':date,
//   };

//   factory EditNotes.fromMap(Map<String,dynamic>map){
//     return EditNotes(
//       title: map['title']??'', 
//       content: map['content']??'', 
//       date: map['date']??''
//       );
//   }

//   String toJson() => json.encode(toMap());
//   factory EditNotes.fromJson(String source) => EditNotes.fromMap(json.decode(source));
// }


