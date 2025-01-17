import 'dart:convert';

import 'package:login_page/Audio/screen/audio.dart';

class Audios{
  final String fileName;
  final String filePath;
  final String uploadedAt;
  final String duration;
  final String format;


  Audios({
    required this.fileName,
    required this.filePath,
    required this.uploadedAt,
    required this.duration,
    required this.format,
  });
  // for sending data to the databse in the format of maps
  Map<String,dynamic> toMap(){
    return{
      "fileName":fileName,
      "filePath":filePath,
      "uploadedAt":uploadedAt,
      "duration":duration,
      "format":format,
    };
  }

// for taking the data from the database in the form of map
  factory Audios.fromMap(Map<String,dynamic> map){
    return Audios(
      fileName: map['fileName'] ?? '',
      filePath: map['filePath']??'', 
      uploadedAt: map['uploadedAt']??'', 
      duration: map['duration']??'', 
      format: map['format']??'',
      );
  }

  // to provide data in the form of json

  String toJson() =>json.encode(toMap());
  // to get in json format from the database
  factory Audios.fromJson(String source) =>  Audios.fromMap(json.decode(source));


}