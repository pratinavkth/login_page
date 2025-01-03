import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_page/global_variable.dart';
import 'package:login_page/notes/models/create_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

class SearchNotes{
  Future<List<Notes>>searchNotes({
    required BuildContext context,
     String? title,
     String? content,
     String? Date,
     String? noteId,

  })async{
    try{
      SharedPreferences pres = await SharedPreferences.getInstance();
      String? userId = pres.getString('user');
      String? token= pres.getString('x-auth-token');

      if(userId != null){
        Notes notesearch = Notes(
          title:title!,
          content: content??'',
          date: Date??'',
          userId: userId,
          noteId: noteId!,

        );
        http.Response res = await http.post(
          Uri.parse('$uri/api/note_search'),
          body:notesearch.toJson(),
          headers: <String,String>{
            'x-auth-token':token!,
          }

          
        );
        if(res.statusCode ==200){
          final List<dynamic> responseData = jsonDecode(res.body);
          return responseData.map((note)=> Notes.fromMap(note)).toList();
        }
        else{
          print('Failed to search Notes:${res.statusCode}');
        }

      }
    }
    catch(e){
      print(e);
    }
    return [];
  }
  // return []
}