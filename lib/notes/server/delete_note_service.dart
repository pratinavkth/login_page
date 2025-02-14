import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_page/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/create_notes.dart';
import 'package:http/http.dart'as http;

class DeleteNotes{

  Future<List<Notes>>deletenotes({
    required BuildContext context,
    required String NoteId,
  })async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      String? userId = prefs.getString('user');
      // String? noteId = 


      if(userId != null ){
        Map<String,dynamic> bodyres = {
          // 'token':token,
          'noteId':NoteId,
        };
        http.Response res = await http.delete(
          Uri.parse('$uri/api/deletenote'),
          body: json.encode(bodyres),
          headers: <String,String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token':token!,
          }
        );
        if(res.statusCode == 200){
          const SnackBar(content: Text('note Deleted Sucessfully'));
        }
      }
    }
    catch(e){
      print(e);
    }
    return [];
  }
  
}