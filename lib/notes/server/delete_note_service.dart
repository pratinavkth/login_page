import 'package:flutter/material.dart';
import 'package:login_page/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/create_notes.dart';
import 'package:http/http.dart'as http;

class DeleteNotes{
  Future<List<Notes>>deletenotes({
    required BuildContext context,


  })async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      String? userId = prefs.getString('user');

      if(userId != null ){
        http.Response res = await http.delete(
          Uri.parse('$uri/api/deletenote'),
          body: token,
          headers: <String,String>{
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