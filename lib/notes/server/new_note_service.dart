import 'package:flutter/material.dart';
import 'package:login_page/notes/models/create_notes.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteService{


  Future<void> addNote({
    required BuildContext context,
    required String title,
    required String content,
    required String Date,
  })async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
          //  String? token = prefs.getString('x-auth-token');
      String? userId = prefs.getString('user');
      print(token);

      if(token !=null ){
      Notes createNote = Notes(
        title: title,
        content: content,
        date: Date,
        userId:userId!,        
        );
        print(createNote.toJson());

        http.Response res = await http.post(
          Uri.parse('$uri/api/note_create'),
          body: createNote.toJson(),
          headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8',
            'x-auth-token': token,   
          }
        );
        print(res.body);
        if (res.statusCode ==200) {
          const SnackBar(content: Text('Note added successfully'));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to add note'),
            )
          );       
        }
    }
    }
    catch(e){
      print(e);
    }
  }  
}
