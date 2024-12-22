// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:login_page/global_variable.dart';
// import 'package:login_page/global_variable.dart';
import 'package:login_page/notes/models/create_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotesFetching{
  Future <List<FetchNotes>>getNotes({
    required BuildContext context,
    
  })
  async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? UserId =prefs.getString('user');
      String? Token =prefs.getString('x-auth-token');

      if(UserId != null){

        // Map<String ,dynamic>bodyres ={
        //   'user_id':UserId,
        // };
        Uri uriId =Uri.parse('$uri/api/notes');
        Map<String, dynamic> bodyres = {'user_id': UserId};

        
        http.Response res = await http.post(
          uriId,
          body: json.encode(bodyres),

          
          headers: <String,String>{
            // 'Content-Type':'application/json; charset=UTF-8',
            'x-auth-token':Token??'',

          },
          
          
          // body:json.encode(bodyres),
          // print(res.body);
        );
        print(res.body);
        print(res.statusCode);
        if(res.statusCode == 200) {
          // const SnackBar(content: Text("notes fetched sucessfully"));

          var jsonData = json.decode(
              res.body); // This will be a Map<String, dynamic>
          print(jsonData);
          print(jsonData.runtimeType);
          var notesData = jsonData['allnotes'];
          print(notesData.runtimeType);
          print(notesData);// This will be the List<dynamic> of notes

          if (notesData != null && notesData is List) {
            print("notes data intercepted");
            List<FetchNotes> notes = notesData
                .where((note) => note is Map<String , dynamic>)
                .map<FetchNotes>(
              (note)=>FetchNotes.fromMap(note as Map<String,dynamic>)).toList();
                // FetchNotes.fromMap(note)).toList();

            print(notes);

            return notes;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No notes found in the frontend server side")),
            );
            return [];
          }
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Notes are not fetched")));
        }

      }

    }
    catch(e){
      print(e);

    }
    return [];
  }

}